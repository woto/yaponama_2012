App = exports ? this

class Realtime

  @send = (data) ->
    console.log 'Browser SEND'
    to_send = JSON.stringify(data)
    console.log to_send
    Realtime.sock.send to_send #if sock and sock.readyState is SockJS.OPEN
    console.log ''

  @connect = ->
    address = "http://" + $('#realtime_address').text() + ":" + $('#realtime_port').text() + "/realtime"
    Realtime.sock = new SockJS(address, undefined, { debug: false, devel: false })

    Realtime.sock.onopen = ->
      console.log 'onopen'

      Realtime.request_authentication()

    Realtime.sock.onmessage = (e) ->
      console.log 'Browser RECV'
      console.log e.data
      received = JSON.parse(e.data)
      data = received.data
      message = received.message
      console.log ''

      switch message
        # RESPONSE SELLERS
        when 'response sellers'
          $('#sellers').html(JSON.stringify(data, null, 4))
          Realtime.render_sellers()

        # RESPONSE AUTHENTICATION
        when 'response authentication'
          $('#authentication').text(data)
          Realtime.request_sellers()

        # SHOW TALK
        when 'show talk'

          # Если мы находимся в области пользователя, за кем закрепляется сообщение ИЛИ 
          # Мы находимся в области отправителя ИЛИ
          # В области адресата

          if ( $('#user_id').html() == data.somebody_id?.toString() ) || ( $('#user_id').html() == data.creator_id?.toString() ) || ( $('#user_id').html() == data.addressee_id?.toString() )

            admin_zone = $('#admin_zone').data('value')
            #is_seller = $('#current_user_role').html() in ['admin', 'manager']

            creator_is_seller = _.find(Realtime.get_parsed_sellers(), (obj) ->
                obj.id is data.creator_id
            )

            addressee_is_seller = _.find(Realtime.get_parsed_sellers(), (obj) ->
                obj.id is data.addressee_id
            )

            # TODO это тут должно быть?
            # вроде логично. В админке получатель
            # меняться не должен, т.к. там влияет только
            # область пользователя в которой находится селлер
            if !admin_zone
              # Если у пришедшего сообщения создатель присутствует в
              # списке менеджеров (т.е. от менеджера) НО НЕ от нас самих же
              if creator_is_seller? && ( data.creator_id.toString() != $('#current_user_id').html() )
                $('#talk_addressee_id').val(data.creator_id)
              # Если получатель менеджер (можем найти адресата в списке)
              # Если мы же отправители (в другом окне например)
              else if addressee_is_seller? && ( data.creator_id.toString() == $('#current_user_id').html() )
                $('#talk_addressee_id').val(data.addressee_id)

              # Если обновление, то дефолтного селлера не меняем
              if data.created_at == data.updated_at
                if (data.addressee_id?)
                  App.select_addressee()
                else
                  # Получается, что это тоже не нужно, т.к. проверка admin_zone
                  # переехала в самый верх
                  ## Если получатель в фронтэнде, т.к. селлер так же получит
                  ## это сообщение и у него сотрется получатель и будет менеджер
                  ## не отвечать на сообщения, а писать всем :)
                  #unless admin_zone
                  App.unselect_addressee()

            $cleared_talk = $(data.cached_talk)
            #$cleared_talk.find(".seller-talk-controls").remove()

            # Если дата изменения не равна дате создания (т.е. обновили)
            if (data.created_at != data.updated_at)
              visible_talk = $('.talk-item[data-id="' + data.id + '"]')
              # И мы нашли элемент, который хотим заменить
              if ( visible_talk.length > 0 )
                visible_talk.replaceWith( $cleared_talk )
            else
              $('#talk-log').prepend( $cleared_talk )
              App.Talk.message('<strong>' + data.creator_id + '</strong>', $cleared_talk)
            # Нужно обновлять скин кнопку, а также потребуется для выставления времени
            window.bootstrapperize()
          else
            # Если я являюсь получателем
            if $('#current_user_id').html() == data.addressee_id?.toString()
              $(document).trigger('private-message', [data])

            # Если получатели все менеджеры
            unless data.addressee_id?
              $(document).trigger('broadcast-message', [data])

          # Если я являюсь адресатом
          aa1 = data.addressee_id?.toString() == $('#current_user_id').html()

          # Если адресат не указан и я не отправитель, но сообщение все таки пришло мне
          aa2 = !data.addressee_id?  && data.creator_id.toString() != $('#current_user_id').html()

          if aa1 || aa2
            Realtime.talk_received data.id


    Realtime.sock.onclose = () ->
      console.log 'onclose'
      _.delay ->
        Realtime.connect()
      , 5000

App.Realtime = Realtime

#####################################

Realtime.talk_received = (id) ->

  $.ajax
    type: "PATCH"
    url: "/user/talks/" + id
    data: { talk: { received: true } }
    dataType: 'script'

Realtime.request_sellers = ->
  data =
    message: 'request sellers'

  Realtime.send data


Realtime.request_authentication = ->
  data =
    message: 'request authentication'
    data: $.cookie('auth_token')

  Realtime.send data


declOfNum = (number, titles) ->
  cases = [2, 0, 1, 1, 1, 2]
  titles[(if (number % 100 > 4 and number % 100 < 20) then 2 else cases[(if (number % 10 < 5) then number % 10 else 5)])]


#Realtime.request_talks = ->
#  data =
#    message: 'request talks'


Realtime.get_parsed_sellers = ->
  JSON.parse($('#sellers').text())


Realtime.render_sellers = ->
  sellers = Realtime.get_parsed_sellers()

  online = _.reduce(sellers, (memo, seller) ->
      memo + seller.online ? 1 : 0
  , 0) 

  online_text = if ( online > 1 ) then online else ''

  $('#we-are-online-note').text('На ваш вопрос прямо сейчас ' + declOfNum(online, ["готов", "готовы", "готовы"]) + " ответить " + online_text + " " + declOfNum(online, ["менеджер", "менеджера", "менеджеров"]) + "." )

  if online > 0
    $('#talk-details').hide()
    $('#talk-details').find('input').prop('disabled', 'disabled')
    $('#we-are-offline-note').hide()
    $('#we-are-online-note').show()
  else
    $('#talk-details').show()
    $('#talk-details').find('input').prop('disabled', '')
    $('#we-are-offline-note').show()
    $('#we-are-online-note').hide()

  Realtime.render_sellers_2()


Realtime.render_sellers_2 = ->
  $('#talk-recipients').html('')

  sellers = Realtime.get_parsed_sellers()
  addressee_id = $('#talk_addressee_id').val()

  for seller in sellers
    if ( addressee_id && seller.id.toString() == addressee_id ) || !addressee_id
      $('#talk-recipients').append(App.resident_template(seller))


init = ->
  Realtime.connect()


$(document).on 'page:load', ->
  Realtime.request_sellers()


$(document).on 'page:update', ->
  #33room = $('#user_id').text()
  #33if room?
  #33  App.Realtime.join_room room


$ ->
  init()
