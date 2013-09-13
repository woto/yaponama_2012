$(document).on 'click.collapse-next.data-api', '[data-toggle=collapse-next]', (e) ->
  $target = $(this).parent().next('.collapse-fields')
  $target.collapse('toggle')
