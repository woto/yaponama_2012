$(document).on 'custom-change', "[rel~='radio-vin-or-frame']", ->
  if $(this).prop('checked')
    if $(this).val() == 'frame'
      $('#car_vin').parent().hide()
      $('#car_frame').parent().show()
    else
      $('#car_vin').parent().show()
      $('#car_frame').parent().hide()

