app.filter('capitalize', function() {
  return function capitalize(str) {
    var str_arr, current_word, cap_arr;

    str_arr = str.split(" ");

    $.each(str_arr, function(index, item) {
      current_word = item.charAt(0).toUpperCase() + item.slice(1);
      cap_arr.push(current_word);
    }); 

    return cap_arr.join(" ");
  }
});