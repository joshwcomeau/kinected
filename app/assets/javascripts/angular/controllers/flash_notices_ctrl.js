function FlashNoticesController($scope, $attrs) {
  this.notice = true;
  this.danger = true;
}


FlashNoticesController.$inject = ['$scope', '$attrs'];
app.controller('FlashNoticesController', ['$scope', '$attrs', FlashNoticesController]);
