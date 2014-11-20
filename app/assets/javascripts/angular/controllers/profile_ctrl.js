function ProfileController($scope, $attrs, $filter, $interval, ProfileDetails, InitialProfileList, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = InitialProfileList;
  this.isMe     = $attrs['myProfile'] == this.profile.id; // Not using === because attrs is a string, whereas this.profile.id is an int.

  console.log(this.isMe);

  this.userFactory   = ProfileDetails;
  this.orderBy       = $filter('orderBy');

  this.selectedProfileIndex = 0;
  this.selectedOrder = 'last_seen';

  this.viewingPhotos  = false;
  this.editing = null;
  this.saving  = null;
  this.loading = null;  

  if ( this.profiles ) this.nextProfile = this.profiles[1]; 

  // Slideshow stuffs
  this.slideshowPosition = 0;
  var user = this;
  if ( this.profile.profile_photos.length > 1 ) {
    $interval(function() {
      user.slideshowPosition++;
      user.slideshowPosition = user.slideshowPosition % user.profile.profile_photos.length;
      console.log(user.slideshowPosition);
    }, 1000);
  }
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

ProfileController.prototype.update = function() {
  var user = this;
  this.saving = true;
  this.userFactory.update({userId: this.profile.id}, this.profile).$promise.then(function(result) {
    user.editing = null;
    user.saving  = null;
    // flash 
    $(".editing").addClass("flash");
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
