rotate_types = (context) ->
  type_store = $(context).closest('.type-store')
  radio_buttons = type_store.find('.type-radio-buttons')
  checked = radio_buttons.filter(':checked')
  unchecked = radio_buttons.not(':checked')

  hidden_block = type_store.find("." + unchecked.val())
  hidden_block.find(":input").prop("disabled", true);
  hidden_block.hide()

  visible_block = type_store.find("." + checked.val())
  visible_block.show()
  visible_block.find(":input").prop("disabled", false);

$(document).on 'change', '.type-radio-buttons', ->
  rotate_types(this)

init = ->
  $('.type-store').each ->
    rotate_types(this)

$(document).on 'click', '.rotate-type', ->
  type_store = $(this).closest('.type-store')
  unchecked = type_store.find('.type-radio-buttons:not(:checked)')
  unchecked.prop('checked', true).change()

$(document).on 'page:load', ->
  init()

$ ->
  init()
