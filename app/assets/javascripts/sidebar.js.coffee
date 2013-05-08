$ ->
  $(document).on 'click', '#chat-button-hide', ->
    $("#main").css("display", "inline").removeAttr("class").addClass "span12"
    $("#sidebar").removeAttr("class").css "display", "none"
    $('#chat-button-hide').hide()
    $('#chat-button-show').show()

  $(document).on 'click', '#chat-button-show', ->
    $("#main").css("display", "inline").removeAttr("class").addClass "span8"
    $("#sidebar").css("display", "inline").removeAttr("class").addClass "span4"
    $('#chat-button-hide').show()
    $('#chat-button-show').hide()





  $(document).on 'click', '#profile-button-hide', ->
    $("#workspace").css("display", "inline").removeAttr("class").addClass "trash-because-of-first-child-assumption"
    # Из-за того, что он не first-child
    #$("#workspace").css("margin-left", "0")
    $("#profile").removeAttr("class").css "display", "none"
    $('#profile-button-hide').hide()
    $('#profile-button-show').show()

  $(document).on 'click', '#profile-button-show', ->
    $("#workspace").css("display", "inline").removeAttr("class").addClass "span9"
    $("#profile").css("display", "inline").removeAttr("class").addClass "span3"
    $('#profile-button-hide').show()
    $('#profile-button-show').hide()
