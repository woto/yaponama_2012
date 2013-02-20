if self == top

  $(window).mousemove (e) ->
    
    window.socket.emit "cursor", JSON.stringify(
      action: "cursor"
      user: 'a'
      page: 
        x: e.pageX
        y: e.pageY
      client:
        x: e.clientX
        y: e.clientY
    )

else

  $ ->
    $('.cursor').css("display", "block")

  window.socket.on "cursor", (msg) ->
    message = JSON.parse(msg)
    action = message.action
    switch action
      when "cursor"
        $('.cursor').css('left', message.page.x)
        $('.cursor').css('top', message.page.y)
