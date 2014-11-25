function ChatsController($scope, $attrs, $firebase, $timeout) {
  var chat = this;
  this.sender      = $attrs.sender;
  this.receiver    = $attrs.receiver;
  this.otherUserId = $attrs.otherUserId;
  this.roomID      = $attrs.roomId;
  this.thumbnail   = $attrs.thumbnail; 
  this.contactIds  = eval($attrs.contacts);
  
  var chatRef      = new Firebase("https://kinected.firebaseio.com/chats/"+this.roomID);
  this.messages    = $firebase(chatRef).$asArray();

  var contactRef   = new Firebase("https://kinected.firebaseio.com/online");
  var allContacts  = $firebase(contactRef).$asArray();
  this.contacts    = [];

  this.selectedContact = null;
  this.selectedContactIsOffline = false;
  this.selectedContactIsOnline = false;

  // Right now, allContacts contains ALL site contacts. Need to restrict this to applicable ones.
  allContacts.$loaded().then(function(contactArr) {
    chat.contacts = _.filter(contactArr, function(c) {
      // Let's also assign the selectedContact while we're here
      if ( Number(c.$id) == chat.otherUserId ) { 
        chat.selectedContact = c; 
        chat.selectedContactIsOnline = chat.onlineNow(c);
        chat.selectedContactIsOffline = !chat.onlineNow(c);

        console.log(chat.onlineNow(c));
      }
      return _.indexOf(chat.contactIds, Number(c.$id)) !== -1;
    });
  });
  //   var current_time = (new Date).getTime() / 1000;


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

ChatsController.prototype.onlineNow = function(contact) {
  if (!contact) { return false }
  var mins_for_online_now = 10, // The other place this is set is in angular-moment-modified.js, line 170.
      threshold_in_ms = mins_for_online_now * 60 * 1000,
      now = new Date().getTime();

  return now - contact.last_seen <= threshold_in_ms;
};

ChatsController.prototype.fromSelf = function(message) { return message.sender == this.sender; };

ChatsController.$inject = ['$scope', '$attrs', '$firebase', '$timeout'];
app.controller('ChatsController', ['$scope', '$attrs', '$firebase', '$timeout', ChatsController]);
