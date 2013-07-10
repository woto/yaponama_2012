App = exports ? this

class NotifySoundToggler

  @get_status = ->

    $('#play-sound-on-new-message').data('value')

  @update_icon = ->

    icon = $('.notify-sound-toggler-icon')

    status = @get_status()

    if status
      icon.removeClass('icon-volume-off')
      icon.addClass('icon-volume-up')
    else
      icon.removeClass('icon-volume-up')
      icon.addClass('icon-volume-off')

  @init: ->

    audio = $('#notify-toggle-audio').get(0)

    play = ->
      try
        audio.currentTime = 0
        audio.play()

    stop = ->
      try
        audio.pause()

    $(document).on 'click', '.notify-sound-toggler-link', (event) =>
     
      # Получаем старый статус
      old_status = @get_status()
      new_status = !old_status

      # Записываем новый статус в хранилище
      $('#play-sound-on-new-message').data('value', new_status)
      # отладочную строчку
      $('#play-sound-on-new-message').text(new_status)
      # и чекбокс
      $('.notify-sound-toggler-checkbox').prop('checked', new_status)

      # В любом случае останавливаем проигрывание звука 
      # индикатора, что звук включен при получении нового сообщения
      stop()

      # Если включили, то бибикаем
      if new_status
        play()
      # Если выключили, то останавливаем проигрываемый звук
      else
        NotifySound.stop()

      # Если не обновится в ближайшее время, то произойдет отправка на сервер

      submit = ->
        $('.notify-sound-toggler-form').trigger('submit.rails')

      debounced_submit = _.debounce(submit, 500);

      debounced_submit()

      @update_icon()

      false

$(document).on 'page:load', ->
  #NotifySoundToggler.init()
  NotifySoundToggler.update_icon()


$ ->
  NotifySoundToggler.init()
  NotifySoundToggler.update_icon()

