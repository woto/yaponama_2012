# TODO Сейчас обновляются все картинки, переделать чтобы обновлялась именно обрабатываемая
#
window.opener.$('img').each ->
  rand = "?rand=" + new Date().getTime()
  $(this).attr('src', $(this).attr('src') + rand)
  $(this).attr('href', $(this).attr('href') + rand)
window.close()
