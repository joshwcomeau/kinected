function NavigationController($scope, $attrs) {
  this.opened = false;

}

NavigationController.prototype.toggle = function() {
  this.opened = !this.opened;
  console.log("click")
}

NavigationController.$inject = ['$scope', '$attrs', '$firebase']
app.controller('NavigationController', ['$scope', '$attrs', '$firebase', NavigationController]);
