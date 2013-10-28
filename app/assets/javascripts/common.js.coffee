$ ->
  init()

$(document).on 'page:change', ->
  init()
  $("*[data-poload]").on "click", (e) ->
    e.preventDefault()
    that = $(this)
    if that.data('visible')
      that.data('visible', false)
      that.popover "hide"
    else
      $.get that.data("poload"), (d) ->
        that.data('visible', true)
        that.popover(trigger: 'manual', html: 'true', content: d).popover "show"

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

  $("[rel~='radio']").each ->

    if $(this).is(':checked')
      $(this).parent().addClass('active')
    else
      $(this).parent().removeClass('active')

    # Нельзя вызывать change
    $(this).trigger('custom-change')

$(document).on 'change', "[rel~='radio']", ->
  $(this).trigger('custom-change')

$(document).on 'change', "[rel~='checkbox']", ->
  $(this).trigger('custom-change')
