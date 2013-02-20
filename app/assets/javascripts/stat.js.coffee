$(document).on 'page:load', ->
  send_stat()

$ ->
  send_stat()

send_stat = ->

  data = 
    stat:
      datetime : moment().format('YYYY-MM-DDTHH:mm:ss')
      location : window.location.href
      title    : document.title
      referrer : document.referrer

  $.post '/stats', data, ->
