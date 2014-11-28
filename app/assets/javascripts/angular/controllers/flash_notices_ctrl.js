function FlashNoticesController($scope, $attrs, FlashMessages) {
  this.show = false;

  // If we're getting something from rails, use that
  if (FlashMessages.length) {
    this.show    = FlashMessages[0][0]; // Either 'notice' or 'alert'
    this.message = FlashMessages[0][1];
  }
}


FlashNoticesController.$inject = ['$scope', '$attrs', 'FlashMessages'];
app.controller('FlashNoticesController', ['$scope', '$attrs', 'FlashMessages', FlashNoticesController]);
