#require['socket.io', ->
if self == top

  $ ->
    size()

  $(window).resize ->
    size()

  size = ->
    window.socket.emit "size", $.toJSON(
      action: 'size'
      user: 'a'
      width: $(window).width() + window.getScrollBarWidth() # TODO refactor usage of getScrollBarWidth
      height: $(window).height() + window.getScrollBarWidth()
      auth_token: $.cookie('auth_token') # TODO testing send auth_token param
    )

  window.socket.on "size", (msg) ->
    message = $.evalJSON(msg)
    #console.log message
    action = message.action
    switch action
      when "size"
        $('#iframe').attr('width', message.width)
        $('#iframe').attr('height', message.height)
