function ChatsController($scope, $attrs, $firebase) {
  this.sender   = $attrs.sender;
  this.receiver = $attrs.receiver;

  var ref = new Firebase("https://kinected.firebaseio.com/");
  var sync = $firebase(ref);
  var messagesArray = sync.$asArray();
  this.messages = messagesArray;
}

ChatsController.$inject = ['$scope', '$attrs', '$firebase']


ChatsController.prototype.pushMessage = function() {
  this.messages.$add({
    sender:     this.sender,
    receiver:   this.receiver,
    message:    this.current_input,
    created_at: Firebase.ServerValue.TIMESTAMP
  });
};

ChatsController.prototype.fromSelf = function(message) { return message.sender == this.sender; };



var app = angular.module('kinected');
app.controller('ChatsController', ['$scope', '$attrs', '$firebase', ChatsController]);
