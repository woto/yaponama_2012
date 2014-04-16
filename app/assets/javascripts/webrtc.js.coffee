#= require JsSIP/dist/jssip-devel

$(document).on "click", "#call", (event) ->
  event.preventDefault()
  
  # Create our JsSIP instance and run it:
  configuration =
    ws_servers: "ws://avtorif.ru:8088/ws"
    uri: "sip:1062@avtorif.ru"
    password: "1062"

  coolPhone = new JsSIP.UA(configuration)
  coolPhone.start()
  
  # Make an audio/video call:
  
  # HTML5 <video> elements in which local and remote video will be shown
  selfView = document.getElementById("my-video")
  remoteView = document.getElementById("peer-video")
  
  # Register callbacks to desired call events
  eventHandlers =
    progress: (e) ->
      console.log "call is in progress"
      return

    failed: (e) ->
      console.log "call failed with cause: " + e.data.cause
      return

    ended: (e) ->
      console.log "call ended with cause: " + e.data.cause
      return

    started: (e) ->
      rtcSession = e.sender
      console.log "call started"
      
      # Attach local stream to selfView
      selfView.src = window.URL.createObjectURL(rtcSession.getLocalStreams()[0])  if rtcSession.getLocalStreams().length > 0
      
      # Attach remote stream to remoteView
      remoteView.src = window.URL.createObjectURL(rtcSession.getRemoteStreams()[0])  if rtcSession.getRemoteStreams().length > 0
      return

  options =
    eventHandlers: eventHandlers
    mediaConstraints:
      audio: true
      video: false

  coolPhone.call "sip:1061@avtorif.ru", options
  return


#coolPhone.call('89169072788', options);
