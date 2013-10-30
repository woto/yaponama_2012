$(document).on 'page:load', ->

  send_stat()

$ ->
  window.referrer = document.referrer

  send_stat()

send_stat = ->

  # Таким образом мы получаем не просто смещение временной зоны
  # а именно реальную разницу между временем на сервере и часах
  # посетителя

  time = $('#server-time').text()

  zone = moment().zone()
  $('#debug-zone').text(zone)

  server = moment(time)
  $('#debug-server').text(server)

  local = moment()
  $('#debug-local').text(local)

  offset = Math.round(server.diff(local) / 1000 / 60 / 60)
  $('#debug-offset').text(offset)

  data = 
    russian_time_zone_auto_id: offset
    stat:
      location: window.location.href
      title: document.title
      referrer: window.referrer
      screen_width: screen.width
      screen_height: screen.height
      client_width: $(window).width()
      client_height: $(window).height()

  window.referrer = window.location.href 

  $.post '/stats', data, ->
    # Сохраняем в элементе, чтобы поймать в Capybara
    $('#debug-stat-result').removeClass('incomplete').addClass('complete').text(JSON.stringify(data, null, 4))
