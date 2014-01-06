App = exports ? this

class NotifyWindow
  @_visible: false

  @visible = ->
    @_visible

    #@_stopAnimateTitle = ->
    #  NotifyWindow.animation_running = false
    #  $(document).attr("title", @original_title)
    #  clearTimeout NotifyWindow.animation_id

    #@_animateTitle = ->
    #  title = $(document).attr("title")
    #  $(document).attr "title", title + "<"
    #  NotifyWindow.animation_id = setTimeout NotifyWindow._animateTitle, 1000

    #@_startAnimateTitle = ->
    #  unless NotifyWindow.animation_running
    #    NotifyWindow.animation_running = true
    #    @original_title = $(document).attr("title")
    #    NotifyWindow._animateTitle()

  @show = (title, text) ->
    @_visible = true
    #@_startAnimateTitle()
    $('#talk-notify').popover('destroy')
    $('#talk-notify').attr('data-content', text)
    $('#talk-notify').attr('data-original-title', @close_button_template + $('#sound-standard').html() + title)
    $('#talk-notify').popover('show')

  @hide = ->
    @_visible = false
    #@_stopAnimateTitle()
    NotifySound.stop()
    $('#talk-notify').popover('hide')

  @close_button_template = '
    <button id="hide-notify" aria-hidden="true" class="control" data-dismiss="modal" type="button">
      <i class="fa fa-times fa-lg"></i>
    </button>
  '

App.NotifyWindow = NotifyWindow

$(document).on 'click', '#hide-notify', ->
  App.NotifyWindow.hide()
  # Stop Event Propagation
  false
