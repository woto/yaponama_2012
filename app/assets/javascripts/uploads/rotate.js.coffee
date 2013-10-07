#= require jquery.transit/jquery.transit

$(document).on 'click', '.rotate-button', (event) ->
  event.preventDefault()
  angle = parseInt $('#upload_angle').val()
  angle -= $(this).data('angle')

  $('#upload_angle').val(angle)
  $('#img-rotate').transition rotate: angle
