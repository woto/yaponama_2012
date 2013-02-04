# TODO Refactor
window.getCookieChat = ->
  if $.cookie('chat')?
    cookie_chat = JSON.parse($.cookie('chat'))
  else
    cookie_chat = {}
