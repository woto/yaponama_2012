$(document).on('click', '#call', function(event) {

  event.preventDefault();

  // Create our JsSIP instance and run it:

  var configuration = {
    'ws_servers': "ws://avtorif.ru:8088/ws",
    'uri': "sip:1062@avtorif.ru",
    'password': "1062"
  };

  var coolPhone = new JsSIP.UA(configuration);

  coolPhone.start();


  // Make an audio/video call:

  // HTML5 <video> elements in which local and remote video will be shown
  var selfView =   document.getElementById('my-video');
  var remoteView =  document.getElementById('peer-video');

  // Register callbacks to desired call events
  var eventHandlers = {
    'progress': function(e){
      console.log('call is in progress');
    },
    'failed': function(e){
      console.log('call failed with cause: '+ e.data.cause);
    },
    'ended': function(e){
      console.log('call ended with cause: '+ e.data.cause);
    },
    'started': function(e){
      var rtcSession = e.sender;

      console.log('call started');

      // Attach local stream to selfView
      if (rtcSession.getLocalStreams().length > 0) {
        selfView.src = window.URL.createObjectURL(rtcSession.getLocalStreams()[0]);
      }

      // Attach remote stream to remoteView
      if (rtcSession.getRemoteStreams().length > 0) {
        remoteView.src = window.URL.createObjectURL(rtcSession.getRemoteStreams()[0]);
      }
    }
  };

  var options = {
    'eventHandlers': eventHandlers,
    'mediaConstraints': {'audio': true, 'video': false}
  };

  coolPhone.call('sip:1061@avtorif.ru', options);
  //coolPhone.call('89169072788', options);

});
