function ProfileController($scope, $attrs, $filter, ProfileDetails, InitialProfileList, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = InitialProfileList;

  this.user_factory  = ProfileDetails;

  this.selectedProfileIndex = 0;
  this.selectedOrder = 'last_seen';
  this.nextProfile = this.profiles[1];

  var user = this;
  this.orderMatches = function() {
    user.loading = true;
    user.profiles = $filter('orderBy')(user.profiles, user.selectedOrder);

    // Update all our properties to reflect this new order.
    user.selectedProfileIndex = 0;
    user.selectedProfileId    = user.profiles[user.selectedProfileIndex].id;
    user.previousProfile      = null;
    user.nextProfile          = user.profiles[user.selectedProfileIndex+1];

    // Fetch this data from the server
    user.user_factory.get({userId: user.selectedProfileId}).$promise.then(function(result) {
      user.loading = false;
      user.profile = result;    
    });

  };
}

ProfileController.prototype.goToMatch = function(increment) {
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
  this.user_factory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
    user.loading = false;
    user.profile = result;    
  });
};

ProfileController.$inject = ['$scope', '$attrs', '$filter', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', '$filter', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails', ProfileController]);
