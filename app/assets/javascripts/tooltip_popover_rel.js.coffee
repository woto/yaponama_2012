$ ->
  window.bootstrapperize()

$(document).on 'page:change', ->
  window.bootstrapperize()

window.bootstrapperize = ->
  $("[rel~=tooltip]").tooltip()
  $("[rel~=popover]").popover()
