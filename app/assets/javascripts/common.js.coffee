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

# Переинициализация autosize (Автоматический подбор
# высоты поля ввода (textarea) текста сообщения)
App.autosize_init = ->
  $('#talk_text').autosize()

# Переинициализация nanoScroller (Кастомный скроллер чата)
App.nanoscroller_init = ->
  $(".nano").nanoScroller
    preventPageScrolling: true

# Выбрав файл в чате происходит автоматическая отправка
$(document).on 'change', '#talk_file', (event) ->
  $(event.target).closest('form').trigger('submit')

###########

$(document).on 'page:update', ->
  App.talk_init()

$(document).on 'click', '.talk-show', (event) ->
  event.preventDefault()
  App.talk_show()

$(document).on 'click', '#talk-hide', (event) ->
  event.preventDefault()
  App.talk_hide()

# Показываем чат, прячем кнопку службы поддержки
App.talk_show = ->
  $.cookie('talk', '1', {path: '/' })
  $('#talk-window').show()
  $('#talk-show').hide()
  App.nanoscroller_init()
  App.autosize_init()

# Показываем кнопку службы поддержки, прячем чат
App.talk_hide = ->
  $.cookie('talk', '0', {path: '/' })
  $('#talk-window').hide()
  $('#talk-show').show()

# Инициализация, проверяем cookie talk и на основе него
# решаем что показать, а что скрыть (окно чата и кнопка
# службы поддержки). Если cookie = talk пустой, то показываем
App.talk_init = ->
  if $.cookie('talk') == '1' || !($.cookie('talk')?)
    App.talk_show()
  else
    App.talk_hide()
