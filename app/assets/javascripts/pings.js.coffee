# Мы получаем путь напр. /user/pings или /admin/users/xxx/pings
# и отправляем на него последний известный нам id
ping = ->

  pings_path = $('#pings_path').text()
  if pings_path.length > 0
    $.post(pings_path,
      talk_item_id: $('#talk-log').find('.talk-item:first').data('id')
    ).always (data) ->
      setTimeout ping, 5000

$ ->
  ping()
