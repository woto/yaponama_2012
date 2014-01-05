$(document).on 'page:update', ->
  $("#slide-top").affix
    offset:
      top: 0
      #bottom: ->
      #  @bottom = $("footer").outerHeight(true)

$(document).on 'click', '#slide-top', ->
  $("html, body").animate({scrollTop: 0}, 'fast')
