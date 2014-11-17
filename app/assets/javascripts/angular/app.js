var app = angular.module('kinected', ['firebase', 'ngAnimate']);

$(document).on('ready page:load', function() {
  angular.bootstrap("body", ['kinected'])
});
