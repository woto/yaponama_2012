# join on click
join = (name) ->
  port = 80
  host = window.location.host.split(":")[0]
  window.socket = io.connect("http://" + host + ":" + port)
  $(document).trigger('socket.joined', [1011]);

$(document).ready ->
  connect()

$(document).on 'page:load', ->
  connect()
  
connect = ->
    # send join message
    window.socket.emit "join", JSON.stringify(user: name)
    container = $("div#msgs")
    
    window.socket.on "chat", (msg) ->
      #console.log message
      message = JSON.parse(msg)
      action = message.action
      struct = container.find("li." + action + ":first")
      if struct.length < 1
        console.log "Could not handle: " + message
        return
      
      # get a new message view from struct template
      messageView = struct.clone()
      
      # set time
      messageView.find(".time").text (new Date()).toString("HH:mm:ss")
      switch action
        when "message"

          #audio = document.createElement("audio")
          #document.body.appendChild audio
          #audio.src = "http://rpg.hamsterrepublic.com/wiki-images/2/21/Collision8-Bit.ogg"
          #audio.play()

          matches = undefined
          
          # someone starts chat with /me ... 
          if matches = message.msg.match(/^\s*[\/\\]me\s(.*)/)
            messageView.find(".user").text message.user + " " + matches[1]
            messageView.find(".user").css "font-weight", "bold"
          
          # normal chat message								
          else
            messageView.find(".user").text message.user
            messageView.find(".message").text ": " + message.msg
        when "control"
          messageView.find(".user").text message.user
          messageView.find(".message").text message.msg
          messageView.addClass "control"
      
      # color own user:
      messageView.find(".user").addClass "self"  if message.user is name
      
      # append to container and scroll
      container.find("ul").append messageView.show()
      container.scrollTop container.find("ul").innerHeight()

    
    # new message is send in the input box
    $("#channel form").submit (event) ->
      event.preventDefault()
      input = $(this).find(":input")
      msg = input.val()
      window.socket.emit "chat", JSON.stringify(
        action: "message"
        user: name
        msg: msg
      )
      input.val ""

  ## show join box
  #
  #$("#ask").show()
  #$("#ask input").focus()
  #$("#ask input").keydown (event) ->
  #  $("#ask a").click()  if event.keyCode is 13

  join Math.random().toString()[0..4]
  ## join on enter
  #$("#ask a").click ->
  #  join $("#ask input").val()
  #  $("#ask").hide()
  #  $("#channel").show()
  #  $("input#message").focus()
