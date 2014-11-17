app.filter('dateToAge', function() {
  // This function is a little clunky and not 100% precise, but it's fast and easy to read.
  return function calculateAge(birthdate) {
    var date_obj, difference_in_ms, epoch_date;
    
    // First we need a Javascript Date object. Rails passes us the ms since epoch
    date_obj  = new Date(birthdate)

    difference_in_ms  = Date.now() - date_obj.getTime();
    epoch_date        = new Date(difference_in_ms);
    
    return Math.abs(epoch_date.getUTCFullYear() - 1970)
  }
});