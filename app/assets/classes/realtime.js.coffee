App = exports ? this

class Realtime

  @connect = ->
    #" + Math.floor(Math.random() * (10000000 - 1 + 1)) + 1 +"realtime.
    Realtime.talk_socket = new SockJS("http://" + $('#realtime_address').text() + ":" + $('#realtime_port').text() + "/talk")

    Realtime.talk_socket.onopen= ->

      data = 
        message: 'authenticate'
        payload: $.cookie('auth_token')

      Realtime.talk_socket.send JSON.stringify(data) #if sock and sock.readyState is SockJS.OPEN

    Realtime.talk_socket.onmessage = (e) ->

      data = JSON.parse(e.data)

      switch data['message']

        when 'update residents'
          user_id = $('#talk-room').data('user_id')
          if user_id? && user_id.toString() == data['room'].toString()
            $('#talk-residents').html('')
            for resident in data['residents']
              $('#talk-residents').append(SHT['talks/resident'](resident))
          Holder.run()

        when 'authenticated'

          Realtime.join_room $('#current_user_id').text()

          room = $('#talk-room').data('user_id')
          if room?
            Realtime.join_room room

        when 'new talk'
          data = data['talk']
          $('#talk-log-inner').prepend( SHT['talks/talk'](data) )
          App.Talk.message('<strong>'+data['creator']+'</strong>', data['text'])
          #alert data['payload']

      console.log data

    Realtime.talk_socket.onclose = ->
      _.delay ->
        Realtime.connect()
      , 1000

  @join_room = (room) ->

    data = 
      message: 'join room'
      payload: 
        room: room

    Realtime.talk_socket.send JSON.stringify(data)


App.Realtime = Realtime

init = ->
  Realtime.connect()

  #$(document).on 'click', '#connect-manager', (event) ->
  #  event.preventDefault()

$(document).on 'page:load', ->
  room = $('#talk-room').data('user_id') 
  if room?
    App.Realtime.join_room room

$ ->
  init()
