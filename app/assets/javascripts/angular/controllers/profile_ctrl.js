function ProfileController($scope, $attrs, ProfileList, ProfileDetails, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = ProfileList;
  this.factory  = ProfileDetails;
  
  this.selectedProfile = this.profile.id;
  this.selectedProfileIndex = 0;
  this.nextProfile = this.profiles[1];
}

ProfileController.prototype.goToMatch = function(increment) {
  this.selectedProfileIndex += increment;

  // Reset when we've hit the end.
  if ( this.selectedProfileIndex === this.profiles.length ) {
    this.selectedProfileIndex = 0; 
  }
  this.previousProfile = this.profiles[this.selectedProfileIndex - increment];
  this.nextProfile     = this.profiles[this.selectedProfileIndex + increment];
  
  // Get that user's data from the server
  this.selectedProfile = this.profiles[this.selectedProfileIndex].id;
  this.profile = this.factory.get({userId: this.selectedProfile});
};

ProfileController.$inject = ['$scope', '$attrs', 'ProfileList', 'ProfileDetails', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', 'ProfileList', 'ProfileDetails', 'InitialProfileDetails', ProfileController]);
