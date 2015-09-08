$(document).on 'keypress', '[catch-enter]', (e) ->
  if e.which == 13
    e.preventDefault()
    $el = $(this).closest('form').find('[press-enter]')
    $el.click()
    $('#XXX').text('true')
