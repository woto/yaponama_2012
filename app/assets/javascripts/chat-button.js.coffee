root = exports ? this

$ ->
  makeAffix()
  initButton()

$(document).on 'page:load', ->
  makeAffix()
  initButton()

makeAffix = ->
  $('#chat-button').affix()

$(document).on 'click', '#chat-button', ->
  chat_cookie = window.getCookieChat()
  try
    if chat_cookie.display == 'show'
      root.closeChat()
    else
      root.showChat()
  catch error
    root.showChat()

initButton = ->

  $("#chat-button").css("right", "-200px")

  func = ->
    $("#chat-button").animate({
      right: "-50px"
    })
  setTimeout func, 1000


  $('#chat-button').on 'mouseenter', ->
    handlerIn()

  $('#chat-button').on 'mouseleave', ->
    handlerOut()

  handlerIn = ->
    $('#chat-button').animate({
      backgroundColor: "#999",
      right: "-40px"
    }, {duration: 100, queue: false})

  handlerOut = ->
    $('#chat-button').animate({
      backgroundColor: "#555",
      right: "-50px"
    }, {duration: 100, queue: false})
