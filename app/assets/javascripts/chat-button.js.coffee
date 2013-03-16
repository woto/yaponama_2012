$ ->
  initButton()

$(document).on 'page:load', ->
  initButton()

initButton = ->

  func = ->
    $("#chat-button").animate({
      marginRight: "25px"
    })
  setTimeout func, 1000
