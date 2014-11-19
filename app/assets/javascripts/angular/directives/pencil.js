app.directive('pencil', function() {
  return {
    restrict: 'E',
    template: '<div class="edit-icon"><i class="fa fa-pencil"></i></div>',
    link: function(scope, element, attrs) {
      element.children().addClass(attrs.region);
    }
  }
})