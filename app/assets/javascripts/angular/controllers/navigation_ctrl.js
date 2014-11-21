function NavigationController($scope, $attrs) {
  this.opened = false;

}

NavigationController.prototype.toggle = function() {
  this.opened = !this.opened;
  console.log("click")
}

NavigationController.$inject = ['$scope', '$attrs']
app.controller('NavigationController', ['$scope', '$attrs', NavigationController]);
