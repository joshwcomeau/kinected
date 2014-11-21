function MessagesController($scope, $attrs, Message) {
  this.messageFactory = Message;
}


MessagesController.prototype.fun = function() {
};

ChatsController.$inject = ['$scope', '$attrs', 'Message'];
app.controller('ChatsController', ['$scope', '$attrs', '$firebase', 'Message', MessagesController]);
