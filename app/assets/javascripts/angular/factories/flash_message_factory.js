app.factory("FlashMessage", function() {
  this.message = '';
  this.show = '';

  return {
    setShow: function(show) {
      this.show = show;
    },
    setMessage: function(message) {
      this.message = message;
    }
  };
});