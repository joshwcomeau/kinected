var app = angular.module('kinected', ['firebase', 'ngAnimate', 'ngResource', 'angularMoment']);

$(document).on('ready page:load', function() {
  angular.bootstrap("body", ['kinected'])
});
