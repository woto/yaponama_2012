App = exports ? this

class Talk

  @visible: false

  @show = ->
    #$("#main").css("display", "inline").removeAttr("class").addClass "col-sm-7"
    #$("#talk").css("display", "inline").removeAttr("class").addClass "col-sm-5"
    #$.cookie('talk_button', 1, {path: '/' });
    #$('#talk-button-hide').show()
    #$('#talk-button-show').hide()

    @visible = true
    App.Scroller.init()
    App.NotifyWindow.hide()

  @hide = ->
    #$("#main").css("display", "inline").removeAttr("class").addClass "col-sm-12"
    #$("#talk").removeAttr("class").css "display", "none"
    #$.cookie('talk_button', 0, {path: '/' });
    #$('#talk-button-hide').hide()
    #$('#talk-button-show').show()
    @visible = false
    NotifySound.stop()

  @message = (title, text) ->
    unless @visible 
      NotifyWindow.show(title, text)
    NotifySound.play()

App.Talk = Talk

init = ->
  #if $.cookie('talk_button') == '1'
  #  App.Talk.show()
  #else
  #  App.Talk.hide()

$ ->
  init()

$(document).on 'page:load', ->
  init()

$(document).on 'click', '#talk-button-hide', ->
  App.Talk.hide()

$(document).on 'click', '#talk-button-show', ->
  App.Talk.show()

$(document).on 'click', "a[rel='ask-question']", ->
  event.preventDefault()
  # TODO Нужно показать панель с чатом если она скрыта
  App.Talk.show()
  CKEDITOR.instances.talk_talkable_attributes_content.insertHtml("<p>" + $(this).data('topic') + "</p><p></p>");
