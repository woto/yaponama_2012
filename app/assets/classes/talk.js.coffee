App = exports ? this

class Talk

  @visible: false

  @show = ->
    @visible = true
    App.NotifyWindow.hide()

  @hide = ->
    @visible = false
    NotifySound.stop()

  @message = (title, text) ->
    title = "<strong>" + $(text).find('.talk-addresser').html() + "</strong>"
    text = $(text).find('.talk-body').html()

    unless @visible 
      NotifyWindow.show(title, text)
    NotifySound.play()

App.Talk = Talk

$(document).on 'show.bs.modal', '#myModal', ->
  App.Talk.show()

$(document).on 'hidden.bs.modal', '#myModal', ->
  App.Talk.hide()

#$(document).on 'click', "a[rel='ask-question']", ->
$(document).on 'click', "a[rel='ask-question']", (event) ->
  event.preventDefault()
  # TODO Нужно показать панель с чатом если она скрыта
  App.Talk.show()
  CKEDITOR.instances.talk_talkable_attributes_content.insertHtml("<p>" + $(this).data('topic') + "</p><p></p>");
