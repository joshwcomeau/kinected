function ProfileController($scope, $attrs, $filter, ProfileDetails, InitialProfileList, InitialProfileDetails) {
  this.profile  = InitialProfileDetails;
  this.profiles = InitialProfileList;
  this.isMe     = $attrs['myProfile'] == this.profile.id; // Not using === because attrs is a string, whereas this.profile.id is an int.

  console.log(this.isMe);

  this.userFactory   = ProfileDetails;
  this.orderBy       = $filter('orderBy');

  this.selectedProfileIndex = 0;
  this.selectedOrder = 'last_seen';



  this.viewingPhotos = false;
  if ( this.profiles ) this.nextProfile = this.profiles[1]; 
}

ProfileController.prototype.togglePhotos = function() {
  console.log(this.profile.profile_photos);
  this.viewingPhotos = !this.viewingPhotos
  
  // Add some stuff here for handling 'back' button, to undo it
}

ProfileController.prototype.update = function() {
  var user = this;
  
  // Lets start with the obligatory 'get' request
  var user = this.userFactory.get({userId: this.profile.id});

  // Now lets update it
  this.userFactory.update({userId: this.profile.id}, this.profile)
  // this.updateFactory.put({userId: this.selectedProfileId}).$promise.then(function(result) {
  //   user.loading = false;
  //   user.profile = result;    

  //   console.log(result);
  //   console.log(user.profile.self_summary);
    
  // });
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


ProfileController.$inject = ['$scope', '$attrs', '$filter', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', '$filter', 'ProfileDetails', 'InitialProfileList', 'InitialProfileDetails', ProfileController]);
