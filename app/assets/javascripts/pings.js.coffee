App = exports ? this

# Мы хотим отправлять пинг:
# 1. При первом заходе на сайте или переходе по ссылке (с turbolinks)
# 2. Регулярно каждые 5 сек

throttled = _.throttle((-> setTimeout ping, 5000), 5000 )

# Мы получаем путь напр. /user/pings или /admin/users/xxx/pings
# и отправляем на него последний известный нам id
ping = ->

  pings_path = $('#pings_path').text()
  if pings_path.length > 0
    $.post(pings_path,
      talk_item_id: $('#talk-log').find('.talk-item:first').data('id')
    ).always (data) ->
      throttled()

$(document).on 'page:change', ->
  ping()
