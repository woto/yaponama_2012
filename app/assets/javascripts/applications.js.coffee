$(window).mousemove (e) ->
  pageCoords = "( " + e.pageX + ", " + e.pageY + " )"
  clientCoords = "( " + e.clientX + ", " + e.clientY + " )"
  $("#div1").text "( e.pageX, e.pageY ) : " + pageCoords
  $("#div2").text "( e.clientX, e.clientY ) : " + clientCoords

$(window).resize ->
  $("#div3").text 'resize -> $(window).width()' + $(window).width()
  $("#div4").text 'resize -> $(window).height()' + $(window).height()

$ ->
  $("#div5").text '$(window).width()' + $(window).width()
  $("#div6").text '$(window).height()' + $(window).height()

