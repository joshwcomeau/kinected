function FlashMessagesController($scope, $attrs, FlashMessage) {
  this.factory = FlashMessage;

  var initial = eval($attrs.initial);
  if (initial.length) {
    FlashMessage.show = initial[0][0];
    FlashMessage.message = initial[0][1];
  }
}


FlashMessagesController.$inject = ['$scope', '$attrs', 'FlashMessage'];
app.controller('FlashMessagesController', ['$scope', '$attrs', 'FlashMessage', FlashMessagesController]);
