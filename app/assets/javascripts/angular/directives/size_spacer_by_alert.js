app.directive('sizeSpacerByAlert', function () {
  return {
    restrict: 'A',
    scope: true,
    priority: 0,
    link: function (scope, element, attrs) {
      var alert, alertHeight, alertHeightCss;

      alert          = $(attrs.alert);
      alertHeightCss = alert.css("height");
      alertHeight    = alertHeightCss.substring(0, alertHeightCss.length - 2);

      element.height(alertHeight);
    }
  }
});
