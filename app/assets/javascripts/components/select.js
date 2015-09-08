$(function() {
  return $("[rel~='select']").each(function() {
    return $(this).trigger('custom-change');
  });
});

$(document).on('change', "[rel~='select']", function() {
  return $(this).trigger('custom-change');
});
