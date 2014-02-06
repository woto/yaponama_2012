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

  $("[rel~='checkbox']").each ->

    if $(this).is(':checked')
      $(this).parent().addClass('active')
    else
      $(this).parent().removeClass('active')

    # Нельзя вызывать change
    $(this).trigger('custom-change')

  # TODO Это тут только для чернового варианта, убрать
  # Я пока не хочу создавать отдельный обработчик и заморачиваться
  # т.к. кнопка просмотрено/не просмотрено отображается правильно во всех
  # случаях, а используется вызов bootstrapperize для выставления класса
  # active у кнопок просмотра, то я задействовал этот участок

  $("[rel~='talk-read']").each (i, eye) ->
    unless $('#admin_zone').data('value')
      $(eye).closest('fieldset').attr('disabled', 'disabled')


  $("[rel~='radio']").each ->

    if $(this).is(':checked')
      $(this).parent().addClass('active')
    else
      $(this).parent().removeClass('active')

    # Нельзя вызывать change
    $(this).trigger('custom-change')

  $("[rel~='select']").each ->

    $(this).trigger('custom-change')


$(document).on 'change', "[rel~='radio']", ->
  $(this).trigger('custom-change')

$(document).on 'change', "[rel~='checkbox']", ->
  $(this).trigger('custom-change')

$(document).on 'change', "[rel~='select']", ->
  $(this).trigger('custom-change')


###########
