function ProfileController($scope, $attrs, ProfileList, ProfileDetails, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = ProfileList;
  this.factory  = ProfileDetails;
  
  this.selectedProfile = this.profile.id;
  this.selectedProfileIndex = 0;

}

ProfileController.prototype.goToNextMatch = function(match_index) {
  // Advance the filmstrip at the bottom
  this.selectedProfileIndex++;
  if ( this.selectedProfileIndex === this.profiles.length ) {
    this.selectedProfileIndex = 0; // Reset when we've hit the end.
  }
  this.previousProfile = this.profiles[this.selectedProfileIndex-1];
  
  // Get that user's data from the server
  this.selectedProfile = this.profiles[this.selectedProfileIndex].id;
  this.profile = this.factory.get({userId: this.selectedProfile});
};

ProfileController.$inject = ['$scope', '$attrs', 'ProfileList', 'ProfileDetails', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', 'ProfileList', 'ProfileDetails', 'InitialProfileDetails', ProfileController]);
