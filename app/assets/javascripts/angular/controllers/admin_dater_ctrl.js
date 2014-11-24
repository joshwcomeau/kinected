function AdminDaterController($scope, $attrs) {
  var dater = this;

  this.selectedDater = null;
  this.approveModalShown = false;
  this.approveModalToggle = function(clickedDater) { 
    dater.approveModalShown = !dater.approveModalShown;
    dater.selectedDater = clickedDater;
    console.log(dater.approveModalShown);
  };
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
