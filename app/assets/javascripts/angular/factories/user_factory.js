app.factory("User", ["$resource", function($resource) {
  return $resource('/daters/:userId.json', {}, {
    query: { method: 'GET', isArray: false }
  });
}]);