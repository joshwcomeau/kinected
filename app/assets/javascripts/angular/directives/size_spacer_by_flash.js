app.directive('sizeSpacerByFlash', function () {
  return {
    restrict: 'A',
    scope: true,
    priority: 0,
    link: function (scope, element, attrs) {
      var flash, flashHeight, flashHeightCss;

      flash          = $(".flash");
      flashHeightCss = flash.css("height");
      flashHeight    = flashHeightCss.substring(0, flashHeightCss.length - 2);

      element.height(flashHeight);
    }
  }
});
