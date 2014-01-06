$(document).on 'private-message', (event, data) ->
  $('body').css('background', 'red')
  #alert 'Личное сообщение.'
  $('#private-message').html(JSON.stringify(data, null, 4))

$(document).on 'broadcast-message', (event, data) ->
  $('body').css('background', 'blue')
  #alert 'Сообщение всем менеджерам.'
  $('#broadcast-message').html(JSON.stringify(data, null, 4))
