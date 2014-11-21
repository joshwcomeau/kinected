app.factory('Message', ['$resource', function() {
  return $resource('/messages.json');
}]);