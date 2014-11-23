function MessagesController($scope, $attrs) {
  this.viewing = "received"
}


MessagesController.prototype.fun = function() {
};

MessagesController.$inject = ['$scope', '$attrs'];
app.controller('MessagesController', ['$scope', '$attrs', MessagesController]);
