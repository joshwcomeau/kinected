function ProfileController($scope, $attrs, $filter, $interval, ProfileDetails, InitialProfileList, InitialProfileDetails, Favorite, Block) {
  var user = this;
  this.profile  = InitialProfileDetails;
  this.profiles = InitialProfileList;

  // We're creating a 'master' clone. This clone will only update on SAVED changes. This clone is what's displayed to the user.
  this.master   = angular.copy(this.profile);
  
  this.myId     = Number($attrs['myProfile']);
  if (this.profile) {
    this.isMe     = this.myId === this.profile.id;
  }

  this.userFactory      = ProfileDetails;
  this.favoriteFactory  = Favorite;
  this.blockFactory     = Block;
  this.orderBy          = $filter('orderBy');

  this.selectedProfileIndex = 0;
  this.selectedOrder = 'last_seen';

  this.viewingPhotos  = false;
  this.showAll = false;
  this.editing = null;
  this.saving  = null;
  this.loading = null;  


  this.msgModalShown  = false;
  this.imgModalShown  = false;
  this.toggleMsgModal = function() { user.msgModalShown = !user.msgModalShown }
  this.toggleImgModal = function(photo) { 
    console.log(photo);
    user.selectedPhoto = photo;
    user.imgModalShown = !user.imgModalShown 
  }


  if ( this.profiles ) this.nextProfile = this.profiles[1]; 
}


ProfileController.prototype.editSection = function(section) {
  if (this.editing !== section) {
    this.editing = section;
  }
};

ProfileController.prototype.cancelUpdate = function() {
  // Since we've canceled, let's 'reset' our copy from the master data.
  angular.copy(this.master, this.profile);
  this.editing = null;
};

ProfileController.prototype.update = function() {
  var user = this;
  
  this.saving = true;
  this.userFactory.update({userId: this.profile.id}, this.profile).$promise.then(function(result) {
    user.editing = null;
    user.saving  = null;
    // Now that we know it's saved, let's update the local copy so the user sees these changes.
    angular.copy(user.profile, user.master);

  });
};

ProfileController.prototype.favorite = function() {
  // If we aren't currently favoriting them, we're making a call to .create
  // If we are, we're making a call to .destroy
  var user = this;

  if ( !this.profile.favorited ) {
    var favoriteData = {favorite: {
      user_id:        this.myId,
      target_user_id: this.profile.id
    }};

    this.favoriteFactory.create({userId: this.profile.id}, favoriteData).$promise
    .then(function(response) {
      user.profile.favorited = response.result;
      angular.copy(user.profile, user.master);
    });
  } else {
    this.favoriteFactory.destroy({userId: this.profile.id, id: this.profile.favorited.id}, this.profile.favorited).$promise
    .then(function(response) {
      user.profile.favorited = response.result;
      angular.copy(user.profile, user.master);
    });
  }
};

ProfileController.prototype.block = function() {
  var user = this;

  this.blockFactory.create({}, {user_id: this.myId, target_user_id: this.profile.id, status: 0}).$promise
  .then(function(response) {
    // Remove this profile from the array
    user.profiles.splice(user.selectedProfileIndex, 1);
    console.log(user.profiles.length);
    // We've got a situation now where our selectedProfileIndex is referring to a profile that no longer exists.
    // Calling goToMatch ought to fix that, by pulling the new profile at this index.
    user.goToMatch(0);

  });
};

ProfileController.prototype.orderMatches = function() {
  this.loading = true;
  if (this.selectedOrder === 'random') {
    this.profiles = shuffle(this.profiles);
  } else {
    this.profiles = this.orderBy(this.profiles, this.selectedOrder, true);  
  }
  

  // Update all our properties to reflect this new order.
  this.selectedProfileIndex = 0;
  this.selectedProfileId    = this.profiles[this.selectedProfileIndex].id;
  this.previousProfile      = null;
  this.nextProfile          = this.profiles[this.selectedProfileIndex+1];

  // Fetch this data from the server
  var user = this;    
  this.userFactory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
    user.loading = false;
    user.profile = result;    

    console.log(user.selectedProfileId);
    console.log(user.selectedProfileIndex);
    console.log(user.profiles);
  });
};

ProfileController.prototype.goToMatch = function(increment) {
  this.loading = true;
  this.selectedProfileIndex += increment;
  
  // Reset when we've hit the end.
  if ( this.selectedProfileIndex === this.profiles.length ) {
    this.selectedProfileIndex = 0; 
  }

  if ( this.profiles.length ) {
    this.previousProfile   = this.profiles[this.selectedProfileIndex - increment];
    this.nextProfile       = this.profiles[this.selectedProfileIndex + increment];
    this.selectedProfileId = this.profiles[this.selectedProfileIndex].id;   

    var user = this;
    this.userFactory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
      user.loading = false;
      user.profile = user.master = result;    
    });

  } else {
    this.profile = this.master = null;
  }
};


ProfileController.$inject = ['$scope', '$attrs', '$filter', '$interval', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails', 'Favorite', 'Block']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', '$filter', '$interval', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails', 'Favorite', 'Block', ProfileController]);
