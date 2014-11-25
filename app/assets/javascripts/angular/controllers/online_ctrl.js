function OnlineController($scope, $attrs, $firebase) {
  this.userId   = $attrs.userId;
  this.curTime  = $attrs.currentTime;

  var ref  = new Firebase("https://kinected.firebaseio.com/online");
  var sync = $firebase(ref);

  var updated_info = {};
  updated_info[this.userId] = this.curTime

  sync.$update(updated_info);
}


OnlineController.$inject = ['$scope', '$attrs', '$firebase'];
app.controller('OnlineController', ['$scope', '$attrs', '$firebase', OnlineController]);
