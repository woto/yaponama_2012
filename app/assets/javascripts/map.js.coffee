$ ->
  if $('#clientMap').length > 0
    # Выставляем в динамике высоту.
    #$("#clientMap").css('height', 100 + $(window).height() - $('#myTab').offset().top - $('#myTab').height())
    #$("#clientMap").css('height', if $('.tab-content').height() > 300 then 300 else $('.tab-content').height())
    #$("#clientMap").css('height', if $(window).height() > $('.tab-content').height() then 400 else ( if $(window).height() > 300 then 300 else $(window).height()))
    $("#clientMap").css('height', 400)

    $("#clientMapOuter").affix offset:
      top: ->
        x = $('#myTab').offset().top + $('#myTab').height() + 20 - 5
        $('#clientMapOuter').css('marginTop', -x + 'px')
        x
      bottom: ->
        $(document).height() - $("#level").offset().top + 20

        #.outerHeight(true)
        #.offset().top
