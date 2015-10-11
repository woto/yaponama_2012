$(document).on('custom-change', "[data-toggle='optional-attributes']", function() {
  var target = $($(this).data('target'));
  if($(this).is(':checked')) {
    target.hide();
  } else {
    target.show();
  }
});
