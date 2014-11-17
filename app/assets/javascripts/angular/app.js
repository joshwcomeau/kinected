var app = angular.module('kinected', ['firebase', 'ngAnimate', 'ngResource']);

$(document).on('ready page:load', function() {
  angular.bootstrap("body", ['kinected'])
});
