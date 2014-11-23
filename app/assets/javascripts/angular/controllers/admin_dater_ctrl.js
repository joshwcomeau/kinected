function AdminDaterController($scope, $attrs) {
  
}

AdminDaterController.prototype.pushMessage = function() {
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

AdminDaterController.prototype.fromSelf = function(message) { return message.sender == this.sender; };

AdminDaterController.$inject = ['$scope', '$attrs'];
app.controller('AdminDaterController', ['$scope', '$attrs', AdminDaterController]);
