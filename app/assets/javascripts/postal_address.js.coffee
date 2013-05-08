show_or_hide = (item, checked) ->
  if checked
    item.parent().parent().next().hide()
  else
    item.parent().parent().next().show()

$(document).on 'click', '.stand_alone_house', ->
  checked = $(this).hasClass('active')
  $(this).next().next().prop('checked', checked)
  show_or_hide( $(this), checked )

init = ->
  $('.stand_alone_house_checbox').each ->
    checked = $(this).prop('checked')
    if checked
      $(this).prev().prev().addClass('active')
    show_or_hide( $(this).prev().prev(), checked )

$ ->
  init()

$(document).on 'page:load', ->
  init()
