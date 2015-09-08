$(function() {
  return $("[rel~='checkbox']").each(function() {
    if ($(this).is(':checked')) {
      $(this).parent().addClass('active');
    } else {
      $(this).parent().removeClass('active');
    }
    return $(this).trigger('custom-change');
  });
});

$(document).on('change', "[rel~='checkbox']", function() {
  return $(this).trigger('custom-change');
});
