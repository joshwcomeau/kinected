app.directive('ngEnterToSend', function () {
  return function (scope, element, attrs) {
    element.bind("keydown keypress", function (event) {
      if(event.which === 13 && !event.shiftKey) {
        scope.chat.pushMessage();

        event.preventDefault();
      }
    });
  };
});