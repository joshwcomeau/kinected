app.factory("ProfileDetails", ["$resource", function($resource) {
  return $resource('/daters/:userId.json', {}, {
    'update': { method: 'PUT' },
    query:  { method: 'GET', isArray: false }
    
  });
}]);