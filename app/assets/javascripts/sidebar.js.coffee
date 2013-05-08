global = @

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
  $("#workspace").css("display", "inline").removeAttr("class").addClass "trash-because-of-first-child-assumption"
  # Из-за того, что он не first-child
  #$("#workspace").css("margin-left", "0")
  $("#profile").removeAttr("class").css "display", "none"
  $.cookie('profile_button', 0, {path: '/' });
  $('#profile-button-hide').hide()
  $('#profile-button-show').show()

@profile_button_show = ->
  $("#workspace").css("display", "inline").removeAttr("class").addClass "span9"
  $("#profile").css("display", "inline").removeAttr("class").addClass "span3"
  $.cookie('profile_button', 1, {path: '/' });
  $('#profile-button-hide').show()
  $('#profile-button-show').hide()


init = ->
  $(document).on 'click', '#chat-button-hide', ->
    chat_button_hide()

  $(document).on 'click', '#chat-button-show', ->
    chat_button_show()

  $(document).on 'click', '#profile-button-hide', ->
    profile_button_hide()

  $(document).on 'click', '#profile-button-show', ->
    profile_button_show()

  for button in ['profile_button', 'chat_button'] then do ->
    console.log button
    console.log $.cookie(button)
    if $.cookie(button) in ['1']
      method = button + "_show"
    else
      method = button + "_hide"
    global[method]()


$ ->
  init()

$(document).on 'page:load', ->
  init()
