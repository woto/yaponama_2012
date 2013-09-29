$(document).on 'keypress', '[rel="catch-enter"]', (e) ->
  if e.which == 13
    e.preventDefault()
    $el = $(this).parent().find('[rel="press-enter"]')
    $el.click()
    $('#debug-catch-enter').text('true')
