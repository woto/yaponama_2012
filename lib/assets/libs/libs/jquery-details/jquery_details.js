//= require jquery-details/jquery.details.min.js

$(document).on('ready', function() {
  $('html').addClass($.fn.details.support ? 'details' : 'no-details');
  $('details').details();
});
