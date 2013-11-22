$ ->
  url = $.url()
  if url.param('modal')
    $('#modal_form').modal('show')
