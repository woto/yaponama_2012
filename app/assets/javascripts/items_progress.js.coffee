start = ->
  $('#items-progress').show()

stop = ->
  $('#items-progress').hide()

$(document).on "ajax:beforeSend", (xhr, settings) ->
  start()

$(document).on "ajax:complete", (xhr, status) ->
  stop()
