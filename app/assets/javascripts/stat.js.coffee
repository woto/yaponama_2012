$(document).on 'page:load', ->

  send_stat()

$ ->
  window.referrer = document.referrer

  send_stat()

send_stat = ->
  data = 
    russian_time_zone_auto: moment().format('YYYY-MM-DDTHH:mm:ss')
    stat:
      location: window.location.href
      title: document.title
      referrer: window.referrer

  window.referrer = window.location.href 

  $.post '/stats', data,
    # Сохраняем в элементе, чтобы поймать в Capybara
    $('#stat-result').text(JSON.stringify(data))
