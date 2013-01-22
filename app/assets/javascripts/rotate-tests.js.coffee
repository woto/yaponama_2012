$(document).on 'click', '.img-rotate', ->
  angle = $(this).data('angle')

  if angle?
    angle += 90
  else 
    angle = 90

  $(this).data('angle', angle);
  $(this).transition rotate: angle
