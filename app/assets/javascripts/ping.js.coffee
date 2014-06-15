ping = ->

  $.post("/ping",
    talk_item_id: $('#talk-log').find('.talk-item:first').data('id')
  ).done (data) ->
    setTimeout ping, 5000

$ ->
  ping()
