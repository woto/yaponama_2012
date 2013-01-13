if self == top

  $(window).scroll (e) ->
    window.socket.emit "scroll", $.toJSON(
      action: "scroll"
      user: 'a'
      x: window.pageXOffset
      y: window.pageYOffset
    )

window.socket.on "scroll", (msg) ->
  message = $.evalJSON(msg)
  action = message.action
  switch action
    when "scroll"
      $('#iframe').contents().find('html, body').scrollTop(message.y)
      $('#iframe').contents().find('html, body').scrollLeft(message.x)
