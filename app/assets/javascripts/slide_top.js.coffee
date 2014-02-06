$(document).on 'page:update', ->
  $("#slide-top").affix
    offset:
      top: 100
      #bottom: ->
      #  @bottom = $("footer").outerHeight(true)

$(document).on 'click', '#slide-top', (event) ->
  event.preventDefault()
  $("html, body").animate({scrollTop: 0}, 'fast')
