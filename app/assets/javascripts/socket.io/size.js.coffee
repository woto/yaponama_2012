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
      width: $(window).width() # TODO for more accuracy we need consider scrollbars
      height: $(window).height()
    )

  window.socket.on "size", (msg) ->
    message = $.evalJSON(msg)
    #console.log message
    action = message.action
    switch action
      when "size"
        $('#iframe').attr('width', message.width)
        $('#iframe').attr('height', message.height)
