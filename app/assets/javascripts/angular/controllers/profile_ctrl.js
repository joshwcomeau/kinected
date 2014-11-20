function ProfileController($scope, $attrs, $filter, $interval, ProfileDetails, InitialProfileList, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = InitialProfileList;

  // We're creating a 'master' clone. This clone will only update on SAVED changes. This clone is what's displayed to the user.
  this.master   = angular.copy(this.profile);
  
  this.isMe     = $attrs['myProfile'] == this.profile.id; // Not using === because attrs is a string, whereas this.profile.id is an int.

  console.log(this.profile);

  this.userFactory   = ProfileDetails;
  this.orderBy       = $filter('orderBy');

  this.selectedProfileIndex = 0;
  this.selectedOrder = 'last_seen';

  this.viewingPhotos  = false;
  this.showAll = false;
  this.editing = null;
  this.saving  = null;
  this.loading = null;  

  if ( this.profiles ) this.nextProfile = this.profiles[1]; 
}

ProfileController.prototype.togglePhotos = function() {
  this.viewingPhotos = !this.viewingPhotos;
  
  // Add some stuff here for handling 'back' button, to undo it
}


ProfileController.prototype.editSection = function(section) {
  if (this.editing !== section) {
    this.editing = section;
  }
  console.log(this.editing);
}

ProfileController.prototype.cancelUpdate = function() {
  // Since we've canceled, let's 'reset' our copy from the master data.
  angular.copy(this.master, this.profile);
  this.editing = null;
}

ProfileController.prototype.update = function() {
  var user = this;
  
  this.saving = true;
  this.userFactory.update({userId: this.profile.id}, this.profile).$promise.then(function(result) {
    user.editing = null;
    user.saving  = null;
    // Now that we know it's saved, let's update the local copy so the user sees these changes.
    angular.copy(this.profile, this.master);
  });

}

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

  this.previousProfile   = this.profiles[this.selectedProfileIndex - increment];
  this.nextProfile       = this.profiles[this.selectedProfileIndex + increment];
  this.selectedProfileId = this.profiles[this.selectedProfileIndex].id;
  
  // Get that user's data from the server
  var user = this;
  this.userFactory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
    user.loading = false;
    user.profile = result;    
  });
};


ProfileController.$inject = ['$scope', '$attrs', '$filter', '$interval', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', '$filter', '$interval', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails', ProfileController]);
