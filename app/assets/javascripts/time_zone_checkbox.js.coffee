change = ->
  flag = $('#use_auto_russian_time_zone').children('.active').data('checkbox-value')
  $('#user_use_auto_russian_time_zone').prop('checked', flag )
  if flag
    $('#russian_time_zone_manual').hide()
    $('#russian_time_zone_auto').show()
  else
    $('#russian_time_zone_manual').show()
    $('#russian_time_zone_auto').hide()
  
$ ->
  change()

$(document).on "click", '#use_auto_russian_time_zone', ->
  change()

$(document).on 'page:load', (e) ->
  change()

