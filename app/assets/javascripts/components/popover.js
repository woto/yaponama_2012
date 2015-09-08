$(document).popover({
  selector: "[rel~=popover]"
});

$(document).on('click', '[rel~=popover]', function(event) {
  return event.preventDefault();
});
