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
  this.loading = true;

  // Reset when we've hit the end.
  if ( this.selectedProfileIndex === this.profiles.length ) {
    this.selectedProfileIndex = 0; 
  }
  this.previousProfile   = this.profiles[this.selectedProfileIndex - increment];
  this.nextProfile       = this.profiles[this.selectedProfileIndex + increment];
  this.selectedProfileId = this.profiles[this.selectedProfileIndex].id;
  
  // Get that user's data from the server
  var user = this;
  this.factory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
    user.loading = false;
    user.profile = result;    
  });
};

ProfileController.$inject = ['$scope', '$attrs', 'ProfileList', 'ProfileDetails', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', 'ProfileList', 'ProfileDetails', 'InitialProfileDetails', ProfileController]);
