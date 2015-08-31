$ ->
  FastClick.attach(document.body)

App = exports ? this

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

App.throttled = _.throttle(->
  $('#brands-fast-search-form').trigger('submit.rails')
  300)

$(document).on 'input', '.brands-fast-search-input', ->
  App.throttled()

###########

# Обработка кликов на объекте и переход по ссылке, которую находим внутри
$(document).on 'click', '[data-clickable-object]', (event) ->
  clickable = $(event.currentTarget).find('[data-clickable-href]')
  if event.target != clickable[0]
    event.preventDefault()
    $(clickable)[0].click()

###########

$(document).on 'click', '[data-expandable-link]', (event) ->
  event.preventDefault()
  table = $(event.currentTarget).closest('[data-expandable-table]')
  $(event.currentTarget).hide()
  $(table).find('tr').removeClass('hidden')
