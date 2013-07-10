App = exports ? this

class NotifySoundToggler

  @_init: ->

    audio = $('#notify-toggle-audio').get(0)

    play = ->
      try
        audio.currentTime = 0
        audio.play()

    stop = ->
      try
        audio.pause()

    get_status = ->
      $('#play-sound-on-new-message').data('value')

    update_icon = ->
      i = $('.notify-sound-switcher').find('i')

      status = get_status()

      if status
        i.removeClass('icon-volume-off')
        i.addClass('icon-volume-up')
      else
        i.removeClass('icon-volume-up')
        i.addClass('icon-volume-off')


    # Обновляем статус иконки
    update_icon()

    $(document).on 'click', '.notify-sound-switcher', (event) =>
     
      # Получаем старый статус
      old_status = get_status()
      new_status = !old_status

      # Записываем новый статус в хранилище
      $('#play-sound-on-new-message').data('value', new_status)
      # отладочную строчку
      $('#play-sound-on-new-message').text(new_status)
      # и чекбокс
      $(event.currentTarget).find(':checkbox').prop('checked', new_status)

      stop()
      if new_status
        play()
      else
        NotifySound.stop()

      # Если не обновится в ближайшее время, то произойдет отправка на сервер

      submit = ->
        $('#sound-form').trigger('submit.rails')

      debounced_submit = _.debounce(submit, 500);

      debounced_submit()

      # Обновляем статус иконки
      update_icon()

      false

$(document).on 'page:load', ->
  NotifySoundToggler._init()

$ ->
  NotifySoundToggler._init()
