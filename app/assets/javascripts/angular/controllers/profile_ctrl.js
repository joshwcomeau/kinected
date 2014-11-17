function ProfileController($scope, $attrs, filteredProfileList, grabInitialProfileDetails) {
  this.profile  = grabInitialProfileDetails;
  this.profiles = filteredProfileList;
  
  this.selectedProfile = this.profile.id;
  this.selectedProfileIndex = 0;

}

ProfileController.prototype.goToNextMatch = function(match_index) {
  this.selectedProfileIndex++;
  if ( this.selectedProfileIndex === this.profiles.length ) {
    this.selectedProfileIndex = 0; // Reset when we've hit the end.
  }
  this.selectedProfile = this.profiles[this.selectedProfileIndex].id;
  this.previousProfile = this.profiles[this.selectedProfileIndex-1];
  
};

ProfileController.$inject = ['$scope', '$attrs', 'filteredProfileList', 'grabInitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', 'filteredProfileList', 'grabInitialProfileDetails', ProfileController]);
