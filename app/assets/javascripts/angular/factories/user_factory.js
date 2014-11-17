app.factory("ProfileDetails", ["$resource", function($resource) {
  return $resource('/daters/:userId.json', {}, {
    query: { method: 'GET', isArray: false }
  });
}]);