app.factory("ProfileList", ["$resource", function($resource) {
  return $resource('/daters.json', {}, {
    query: { method: 'GET', isArray: true }
  });
}]);