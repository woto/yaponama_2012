App = exports ? this

class Scroller

  @init = ->
    $("#talk-log-holder").nanoScroller
      preventPageScrolling: true
    Scroller.bind()

  @bind = ->
    $(document).on "scrollend", '#talk-log-holder', (e) ->
      id = $('#talk-log-inner').find('.talk-item:last').data('id')
      id = parseInt(id, 10) - 1
      $('#talk-log-holder').css("background", "#888")
      $.getJSON '/admin/users/23/talks/' + id, (data) ->
        $('#talk-log-holder').css("background", '#FFF')
        debugger
        $('#talk-log-inner').append( SHT['talks/talk'](data) )
        $("#talk-log-holder").nanoScroller({preventPageScrolling: true})

App.Scroller = Scroller
