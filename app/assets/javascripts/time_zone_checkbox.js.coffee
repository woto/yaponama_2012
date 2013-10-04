$(document).on 'custom-change', "[rel~='radio-use-auto-russian-time-zone']", ->
  if $(this).prop('checked')
    if $(this).val() == 'true'
      $('#user_russian_time_zone_manual_id').parent().hide()
      $('#user_russian_time_zone_auto_id').parent().show()
    else
      $('#user_russian_time_zone_manual_id').parent().show()
      $('#user_russian_time_zone_auto_id').parent().hide()
