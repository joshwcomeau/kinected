function ProfileController($scope, $attrs, $filter, ProfileDetails, InitialProfileList, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = InitialProfileList;

  this.user_factory  = ProfileDetails;
  this.orderBy       = $filter('orderBy');

  this.selectedProfileIndex = 0;
  this.selectedOrder = 'last_seen';
  if ( this.profiles ) this.nextProfile = this.profiles[1]; 

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
  this.user_factory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
    user.loading = false;
    user.profile = result;    
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
  this.user_factory.get({userId: this.selectedProfileId}).$promise.then(function(result) {
    user.loading = false;
    user.profile = result;    
  });
};


ProfileController.$inject = ['$scope', '$attrs', '$filter', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', '$filter', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails', ProfileController]);
