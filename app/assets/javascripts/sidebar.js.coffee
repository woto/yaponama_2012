global = @
place = undefined
profile = undefined

@chat_button_hide = ->
  $("#main").css("display", "inline").removeAttr("class").addClass "span12"
  $("#sidebar").removeAttr("class").css "display", "none"
  $.cookie('chat_button', 0, {path: '/' });
  $('#chat-button-hide').hide()
  $('#chat-button-show').show()

@chat_button_show = ->
  $("#main").css("display", "inline").removeAttr("class").addClass "span8"
  $("#sidebar").css("display", "inline").removeAttr("class").addClass "span4"
  $.cookie('chat_button', 1, {path: '/' });
  $('#chat-button-hide').show()
  $('#chat-button-show').hide()

@profile_button_hide = ->
  $("#workspace").removeAttr("class").addClass "span12"
  place = $("#profile").parent()
  profile = $("#profile")
  $("#profile").remove()
  $.cookie('profile_button', 0, {path: '/' });
  $('#profile-button-hide').hide()
  $('#profile-button-show').show()

@profile_button_show = ->
  $("#workspace").removeAttr("class").addClass "span8"
  if place? && profile?
    place.prepend(profile)
  $.cookie('profile_button', 1, {path: '/' });
  $('#profile-button-hide').show()
  $('#profile-button-show').hide()


init = ->
  $('#chat-button-hide').on 'click', ->
    chat_button_hide()

  $('#chat-button-show').on 'click', ->
    chat_button_show()

  $('#profile-button-hide').on 'click', ->
    profile_button_hide()

  $('#profile-button-show').on 'click', ->
    profile_button_show()

  for button in ['profile_button', 'chat_button'] then do ->
    if $.cookie(button) in ['1']
      method = button + "_show"
    else
      method = button + "_hide"
    global[method]()


$ ->
  init()

$(document).on 'page:load', ->
  init()
