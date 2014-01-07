$(document).on 'click', "[rel~='show-offer']", (event) ->
  event.preventDefault()
  $(this).closest($('div[itemscope]')).find("[rel~='offers']").collapse('toggle')
