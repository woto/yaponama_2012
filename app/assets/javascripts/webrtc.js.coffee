$(document).on 'click', '#call', (event) ->

  event.preventDefault()

  configuration =
    ws_servers: "ws://avtorif.ru:8088/ws"
    uri: "sip:1060@avtorif.ru"
    password: "1060"
    stun_servers: 'stun:74.125.132.127:19302'
    register: true
    trace_sip: true

  coolPhone = new JsSIP.UA(configuration)
  coolPhone.start()

  # Make an audio/video call:

  # Register callbacks to desired call events
  eventHandlers =
    progress: (e) ->
      console.log "call is in progress"

    failed: (e) ->
      console.log "call failed with cause: " + e.data.cause

    ended: (e) ->
      console.log "call ended with cause: " + e.data.cause

    started: (e) ->
      rtcSession = e.sender
      console.log "call started"
      
  options =
    eventHandlers: eventHandlers
    mediaConstraints:
      audio: true
      video: false

      #coolPhone.call "1061", options
  coolPhone.call "89169072788", options
