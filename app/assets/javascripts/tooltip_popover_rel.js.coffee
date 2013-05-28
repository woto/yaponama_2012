$ ->
  window.bootstrapperize()

$(document).on 'page:change', ->
  window.bootstrapperize()

window.bootstrapperize = ->
  $("[rel~=tooltip]").tooltip()
  $("[rel~=popover]").popover()

  #$("a[rel=popover]").popover()
  #$(".tooltip").tooltip()
  #$("a[rel=tooltip]").tooltip()
