$ ->
  url = $.url()
  if url.param('modal')
    $('#product_modal_form').modal('show')
