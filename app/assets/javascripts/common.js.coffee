$(document).popover({
  selector: "[rel~=popover]"
})

$(document).tooltip({
  selector: "[rel~=tooltip]"
})

$(document).on 'click', '[rel~=popover]',  (event) ->
  event.preventDefault()

$(document).on 'click', "*[data-poload]", (event) ->
  event.preventDefault()
  that = $(this)
  if that.data('visible')
    that.data('visible', false)
    that.popover "hide"
  else
    $.get that.data("poload"), (d) ->
      that.data('visible', true)
      that.popover(trigger: 'manual', content: d).popover "show"


$ ->

  bootstrapperize()

$(document).on 'page:load', ->
  bootstrapperize()

window.bootstrapperize = ->

  #$("#grid-toolbar-columns").on "click", (e) ->
  #  $(".modal-body").load "/render/62805", (result) ->
  #    $("#myModal").modal show: true


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
