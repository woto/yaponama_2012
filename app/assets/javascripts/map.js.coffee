$(document).on 'page:update', ->
  # Выставляем в динамике высоту.
  $("#clientMap").css('height', $(window).height() - $('#myTab').offset().top - $('#myTab').height() - 30 + 50)

  $("#clientMapOuter").affix offset:
    top: ->
      @top = 222
      # Это число так же фигурирует в js
    bottom: ->
      @bottom = $(document).height() - $("#level").offset().top + 15
      #@bottom = $("#level").offset().top
      #@bottom = $("footer").outerHeight(true) + 50

      #bottom: ->
      ##  #@bottom = $(".bs-footer").outerHeight(true)
      #  @bottom = 10
  #$("#clientMapOuter").affix
  #  offset:
  #    top: 100

