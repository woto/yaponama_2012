start = ->
  $('#items-progress').show()

stop = ->
  $('#items-progress').hide()


$(document).on "ajax:beforeSend", (xhr, settings) ->
  if $(xhr.target).closest('#new_grid').length > 0
    start()

$(document).on "ajax:complete", (xhr, status) ->
  if $(xhr.target).closest('#new_grid').length > 0
    stop()
