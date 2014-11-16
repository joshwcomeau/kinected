function ProfileController($scope, $attrs, filteredProfileList, grabInitialProfileDetails) {
  this.profiles = filteredProfileList;
  this.user     = grabInitialProfileDetails;


  console.log(this.user);
  console.log(this.profiles == null);
}

ProfileController.$inject = ['$scope', '$attrs', 'filteredProfileList', 'grabInitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', 'filteredProfileList', 'grabInitialProfileDetails', ProfileController]);
