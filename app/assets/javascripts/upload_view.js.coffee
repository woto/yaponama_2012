$(document).on 'click', '.image-view', (event) ->
  event.preventDefault()
  some_html = '<img src="' + $(this).attr('href') + '" class="img-responsive" /><br />'
  bootbox.alert(some_html)
