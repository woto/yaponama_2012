$ ->
  init()

$(document).on 'page:change', ->
  init()

init = ->
  $("[rel~=tooltip]").tooltip()

  $("[rel~=popover]").popover()

  $("[rel~='checkbox']").each ->

    if $(this).is(':checked')
      $(this).parent().addClass('active')
    else
      $(this).parent().removeClass('active')

    # Нельзя вызывать change
    $(this).trigger('custom-change')

$(document).on 'change', "[rel~='checkbox']", ->
  $(this).trigger('custom-change')
