$(document).on 'private-message', (event, data) ->
  $('body').css('background', 'red')
  #alert 'Личное сообщение.'
  $('#private-message').html(JSON.stringify(data, null, 4))
  # Забавно, что обнаружил после месяцев работы. ( Приватные сообщения-то при котором нотифай сообщение не должно 
  # отображаться [например без области пользователя или в чужой области ])(?) я пропускал :(
  NotifySound.play()

$(document).on 'broadcast-message', (event, data) ->
  $('body').css('background', 'blue')
  #alert 'Сообщение всем менеджерам.'
  $('#broadcast-message').html(JSON.stringify(data, null, 4))
  # Забавно, что обнаружил после месяцев работы. Сообщения-то всем я пропускал :(
  NotifySound.play()
