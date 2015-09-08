$(document).on('custom-change', "[vin_or_frame]", function() {
  if ($(this).prop('checked')) {
    if ($(this).val() === 'frame') {
      $('[frame]').show();
      $('[vin]').hide();
    } else {
      $('[frame]').hide();
      $('[vin]').show();
    }
  }
});
