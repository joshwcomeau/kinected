app.factory("Favorite", ["$resource", function($resource) {
  return $resource('/daters/:userId/favorites/:id', {}, {
    'create':  { method: 'POST' },
    'destroy': { method: 'DELETE' }
    
  });
}]);