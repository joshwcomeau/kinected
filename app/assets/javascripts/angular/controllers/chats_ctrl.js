function ChatsController($scope, $attrs, $firebase, $timeout) {
  this.sender     = $attrs.sender;
  this.receiver   = $attrs.receiver;
  this.roomID     = $attrs.roomId;
  this.thumbnail  = $attrs.thumbnail; 

  var firebase_string = "https://kinected.firebaseio.com/chats/"+this.roomID;
  var ref = new Firebase(firebase_string);
  var sync = $firebase(ref);

  var messagesArray = sync.$asArray();
  this.messages = messagesArray;

  this.hi = function() { console.log("hi"); }

  // Callback when a message is added
  this.messages.$watch(function() {
    // Wait a few milliseconds for the DOM to update
    $timeout(function() {
      $(".chat-contents").scrollTop($(".chat-contents")[0].scrollHeight);  
    }, 50);
  });
}

ChatsController.prototype.pushMessage = function() {
  // Don't do anything on blank inputs
  if ( this.current_input ) {
    this.messages.$add({
      sender:     this.sender,
      receiver:   this.receiver,
      thumbnail:  this.thumbnail,
      message:    this.current_input,
      created_at: Firebase.ServerValue.TIMESTAMP
    });
    // Clear the input
    this.current_input = '';
  }
};

ChatsController.prototype.fromSelf = function(message) { return message.sender == this.sender; };

ChatsController.$inject = ['$scope', '$attrs', '$firebase', '$timeout'];
app.controller('ChatsController', ['$scope', '$attrs', '$firebase', '$timeout', ChatsController]);
