root = exports ? this

$(document).on 'page:load', ->
  makeDraggable()
  initChat()

$ ->
  makeDraggable()
  initChat()

makeDraggable = ->
  $( "#channel" ).draggable
    cancel: "#msgs, .form-inline",
    stop: ->
      cookie_chat = JSON.parse($.cookie('chat')) || {}
      $.extend cookie_chat,
        position:
          top: $('#channel').css('top')
          left: $('#channel').css('left')
      $.cookie( 'chat', JSON.stringify(cookie_chat) )

root.initChat = ->
  cookie_chat = JSON.parse($.cookie('chat')) || {}
  if cookie_chat.display? && cookie_chat.display == 'show'
      root.showChat()

$(document).on 'click', '#close-chat', (e) ->
  e.preventDefault()
  root.closeChat()

root.showChat = ->
  $('#channel').show();
  cookie_chat = JSON.parse($.cookie('chat')) || {}
  if cookie_chat.position?
    $('#channel').css('left', cookie_chat.position.left)
    $('#channel').css('top', cookie_chat.position.top)
  $.extend(cookie_chat, display: 'show')
  $.cookie('chat', JSON.stringify(cookie_chat))

root.closeChat = ->
  cookie_chat = JSON.parse($.cookie('chat')) || {}
  $.extend cookie_chat, display: 'hide'
  $.extend cookie_chat,
    position:
      top: $('#channel').css('top')
      left: $('#channel').css('left')
  $.cookie('chat', JSON.stringify(cookie_chat))
  $('#channel').hide()
