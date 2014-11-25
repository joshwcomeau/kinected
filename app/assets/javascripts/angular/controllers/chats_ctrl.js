function ChatsController($scope, $attrs, $firebase, $timeout) {
  var chat = this;
  this.sender     = $attrs.sender;
  this.receiver   = $attrs.receiver;
  this.roomID     = $attrs.roomId;
  this.thumbnail  = $attrs.thumbnail; 
  this.contactIds = eval($attrs.contacts);
  
  var chatRef     = new Firebase("https://kinected.firebaseio.com/chats/"+this.roomID);
  this.messages   = $firebase(chatRef).$asArray();

  var contactRef  = new Firebase("https://kinected.firebaseio.com/online");
  var allContacts = $firebase(contactRef).$asArray();
  this.contacts   = [];


  // Right now, allContacts contains ALL site contacts. Need to restrict this to applicable ones.
  allContacts.$loaded().then(function(contactArr) {
    chat.contacts = _.filter(contactArr, function(c) {
      return _.indexOf(chat.contactIds, Number(c.$id)) !== -1;
    });

    console.log(chat.contacts);
  });
  //   var current_time = (new Date).getTime() / 1000;

    // chat.onlineContacts = _.filter(contactArr, function(c) {
    //   console.log((current_time - c.$value < 720));
    //   return _.indexOf(chat.contacts, Number(c.$id)) !== -1 && (current_time - c.$value < 720);
    // });
  //   console.log(chat.onlineContacts);
  // });

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
