$(document).on 'click.collapse-next.data-api', '[data-toggle=collapse-next]', (e) ->
  $target = $(this).closest("[rel='collapse-next']").next()
  $target.collapse('toggle')
