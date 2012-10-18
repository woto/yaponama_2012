$(document).on 'click', '#check_uncheck_products', ->
  $('input.product[type=checkbox]').attr('checked', typeof($(this).attr('checked')) != 'undefined' ).change()

$(document).on 'change', 'input.product[type=checkbox]', ->
  form = $('form')
  $(form).submit()
