$(document).on 'click', '#check-uncheck-items', ->
  $('input.item[type=checkbox]').attr('checked', typeof($(this).attr('checked')) != 'undefined' ).change()

$(document).on 'click', '#check-items', (e) ->
  e.preventDefault()
  $('input.item[type=checkbox]').prop('checked', true).change()

$(document).on 'click', '#uncheck-items', (e) ->
  e.preventDefault()
  $('input.item[type=checkbox]').prop('checked', false).change()

$(document).on 'change', 'input.item[type=checkbox]', ->
  form = $('form')
  $(form).submit()
