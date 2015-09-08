$(document).on('custom-change', "[stand_alone_house]", function() {
  var room;
  room = $('[room]');
  if ($(this).is(':checked')) {
    return room.hide();
  } else {
    return room.show();
  }
});
