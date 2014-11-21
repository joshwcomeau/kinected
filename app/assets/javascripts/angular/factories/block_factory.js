app.factory("Block", ["$resource", function($resource) {
  return $resource('/permissions.json', {}, {
    'create':  { method: 'POST' }    
  });
}]);