auth_window = undefined

$(document).on 'click', '#auth-buttons a', (event) ->
  event.preventDefault()
  auth_window = window.open $(this).attr('href'), "login", "scrollbars=no, resizable=no, width=" + $(this).data('width') + ", height=" + $(this).data('height')

$(document).on 'auth_done', '#auth-result', ->
  auth_window.close()
