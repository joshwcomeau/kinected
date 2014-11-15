function ProfileController($scope, $attrs, filteredProfileList, grabInitialProfileDetails) {
  this.profiles = filteredProfileList;
  this.profile  = grabInitialProfileDetails;


  console.log(this.profile);
  console.log(this.profiles);
}

ProfileController.$inject = ['$scope', '$attrs', 'filteredProfileList', 'grabInitialProfileDetails']

var app = angular.module('kinected');
app.controller('ProfileController', ['$scope', '$attrs', 'filteredProfileList', 'grabInitialProfileDetails', ProfileController]);
