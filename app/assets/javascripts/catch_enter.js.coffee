init = ->
  $('.catch-enter').keypress (e) ->
    if e.which == 13
      e.preventDefault()
      $(this).parent().find('.press-enter').click()

$ ->
  init()

$(document).on 'page:load', ->
  init()
