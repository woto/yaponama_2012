App = exports ? this

class NotifySound
  # Переменная хранит флаг, символизирующий о том, что мы можем начинать проигрывать аудио
  # без опаски, что в какой-то момент времени оно окажется не дозагруженным
  @_canplaythrough: false

  # Хранит audio тэг
  @_audio: undefined 

  # Меняется на событие playing и pause символизируя текущий статус (проигрывается аудио или нет)
  @_is_playing: false

  # С каждым событием playing увеличивается на еденицу
  @_playing_count: 0

  @_increase_playing_count: ->
    NotifySound._playing_count++
    @_update_increase_playing_count()

  @_update_increase_playing_count: ->
    $('#playing-count').text(NotifySound._playing_count)

  @_change_playing_status: (status) ->
    NotifySound._is_playing = status
    @_update_playing_status()

  @_update_playing_status: ->
    $('#is-playing').text(NotifySound._is_playing)

  @_set_canplaythrough: ->
    NotifySound._canplaythrough = true
    $('#can-play-through').text(NotifySound._canplaythrough)

  @_init: ->
    @_audio = $('#notify-audio')
    @_audio.on 'canplaythrough', ->
      NotifySound._set_canplaythrough()

    @_audio.on 'playing', ->
      NotifySound._increase_playing_count()
      NotifySound._change_playing_status(true)

    @_audio.on 'pause', ->
      NotifySound._change_playing_status(false)

    @_update_increase_playing_count()
    @_update_playing_status()

  @play: ->
    if NotifySound._canplaythrough && $('#play-sound-on-new-message').data('value')
      @_audio[0].pause()
      @_audio[0].currentTime = 0
      @_audio[0].play()
    else
      # TODO потом убедиться что этого условия быть не может

  @stop = ->
    if NotifySound._canplaythrough
      @_audio[0].pause()
    else
      # TODO потом убедиться что этого условия быть не может

$ ->
  NotifySound._init()

$(document).on 'page:load', ->
  NotifySound._init()

App.NotifySound = NotifySound
