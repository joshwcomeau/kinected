app.filter('ageFilter', function() {
  // This function is a little clunky and not 100% precise, but it's fast and easy to read.
  return function calculateAge(birthdate) {
    var date_array, date_m, date_d, date_y, date_obj, difference_in_ms, epoch_date;
    
    // First we need a Javascript Date object. Rails passes us a datestring in format 'yyyy-mm-dd'
    date_array = birthdate.split("-");

    date_y    = date_array[0];
    date_m    = date_array[1] - 1;  // Because JS counts dates from 0 to 11
    date_d    = date_array[2];
    date_obj  = new Date(date_y, date_m, date_d)


    difference_in_ms  = Date.now() - date_obj.getTime();
    epoch_date        = new Date(difference_in_ms);
    
    return Math.abs(epoch_date.getUTCFullYear() - 1970)
  }
});