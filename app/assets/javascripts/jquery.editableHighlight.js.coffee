jQuery.fn.editableHighlight = ->
  $(this).each ->
    el = $(this)
    el.before "<div/>"
    el.prev().width(el.width()).height(el.height()).css(
      position: "absolute"
      "background-color": "#ffff99"
      opacity: ".9"
    ).fadeOut 1500
