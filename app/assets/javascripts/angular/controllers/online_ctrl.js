function OnlineController($scope, $attrs, $firebase) {
  this.userId       = $attrs.userId;
  this.curTime      = $attrs.currentTime;
  this.displayName  = $attrs.displayName;
  this.thumb        = $attrs.thumb;
  this.chattingWith = $attrs.chattingWith;

  var ref  = new Firebase("https://kinected.firebaseio.com/online");
  var sync = $firebase(ref);

  var updated_info = {};
  updated_info[this.userId] = {
    last_seen:     this.curTime,
    display_name:  this.displayName,
    thumb:         this.thumb,
    chatting_with: this.chattingWith
  }

  sync.$update(updated_info);
}


OnlineController.$inject = ['$scope', '$attrs', '$firebase'];
app.controller('OnlineController', ['$scope', '$attrs', '$firebase', OnlineController]);
