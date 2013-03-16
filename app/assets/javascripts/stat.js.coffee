$(document).on 'page:load', ->
  send_stat()

$ ->
  send_stat()

send_stat = ->

  data = 
    russian_time_zone_auto: moment().format('YYYY-MM-DDTHH:mm:ss')
    stat:
      location: window.location.href
      title: document.title
      referrer: document.referrer

  $.post '/stats', data, ->
