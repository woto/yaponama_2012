$(document).on 'page:load', ->
  profileables_buttons()

$ ->
  profileables_buttons()

profileables_buttons = ->
  $(".hover-profileable").hover ->
    $(this).find(".plus-profileable").css("visibility", "visible")
  , ->
    $(this).find(".plus-profileable").css("visibility", "hidden")

  $('.profileable-item').hover ->
    $(this).find('.profileable-item-control').css("visibility", "visible")
  , ->
    $(this).find('.profileable-item-control').css("visibility", "hidden")

source = new EventSource('/stats/events')

source.onmessage = (e) ->
  console.log 'SSE onmessage'
  data = $.parseJSON(e.data).data
  $('#events').append($('<li>').text("#{data.user_id}: #{data.location}"))

source.onopen =->
  console.log 'SSE onopen'

source.onerror =->
  console.log 'SSE onerror'

source.addEventListener 'stats.create', (e) ->
  # TODO Заменить JSON.parse на $.parseJSON
  data = $.parseJSON(e.data)
  $('#events').append($('<li>').text("#{data.user_id}: #{data.location}"))
