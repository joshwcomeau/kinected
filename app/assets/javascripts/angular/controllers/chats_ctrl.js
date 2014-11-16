function ChatsController($scope, $attrs, $firebase) {
  this.sender     = $attrs.sender;
  this.receiver   = $attrs.receiver;
  this.roomID     = $attrs.roomId;
  this.thumbnail  = $attrs.thumbnail; 

  var firebase_string = "https://kinected.firebaseio.com/chats/"+this.roomID;
  var ref = new Firebase(firebase_string);
  var sync = $firebase(ref);

  var messagesArray = sync.$asArray();
  this.messages = messagesArray;
}

ChatsController.$inject = ['$scope', '$attrs', '$firebase']


ChatsController.prototype.pushMessage = function() {
  this.messages.$add({
    sender:     this.sender,
    receiver:   this.receiver,
    thumbnail:  this.thumbnail,
    message:    this.current_input,
    created_at: Firebase.ServerValue.TIMESTAMP
  });
  // Clear the input
  this.current_input = '';
};

ChatsController.prototype.fromSelf = function(message) { return message.sender == this.sender; };

app.controller('ChatsController', ['$scope', '$attrs', '$firebase', ChatsController]);
