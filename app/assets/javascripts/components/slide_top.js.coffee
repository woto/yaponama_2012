App = exports ? this

App.toTop = ->
  $("html, body").animate({scrollTop: 0}, 'fast')

$ ->
  $("#slide-top").affix
    offset:
      top: 100
      #bottom: ->
      #  @bottom = $("footer").outerHeight(true)

$(document).on 'click', '#slide-top', (event) ->
  event.preventDefault()
  App.toTop()
  #$("html, body").animate({scrollTop: 0}, 'fast')
