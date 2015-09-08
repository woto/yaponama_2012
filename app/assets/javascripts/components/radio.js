$(function() {
  return $("[rel~='radio']").each(function() {
    if ($(this).is(':checked')) {
      $(this).parent().addClass('active');
    } else {
      $(this).parent().removeClass('active');
    }
    return $(this).trigger('custom-change');
  });
});

$(document).on('change', "[rel~='radio']", function() {
  return $(this).trigger('custom-change');
});
