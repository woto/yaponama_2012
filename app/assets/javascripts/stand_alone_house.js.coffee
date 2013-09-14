$(document).on 'custom-change', "[rel~='checkbox-stand-alone-house']", ->

  room = $(this).closest("[rel='stand-alone-group']").find("[rel='room']")

  if $(this).is(':checked')
    room.hide()
  else
    room.show()
