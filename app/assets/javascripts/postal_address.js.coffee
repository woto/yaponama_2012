show_or_hide = (item, checked, direction) ->
  if checked
    if direction == 'reverse'
      item.parent().parent().next().show()
    else
      item.parent().parent().next().hide()
  else
    if direction == 'reverse'
      item.parent().parent().next().hide()
    else
      item.parent().parent().next().show()

$(document).on 'click', '.stand_alone_house', ->
  checked = $(this).hasClass('active')
  $(this).next().next().prop('checked', checked)
  show_or_hide( $(this), checked, $(this).data('direction') )

init = ->
  $('.checkbox_button_swap').each ->
    checked = $(this).prop('checked')
    if checked
      $(this).prev().prev().addClass('active')
    show_or_hide( $(this).prev().prev(), checked, $(this).data('direction') )

$ ->
  init()

$(document).on 'page:load', ->
  init()
