App = exports ? this

class NotifyWindow
  @_visible: false

  @visible = ->
    @_visible

  @show = (title, text) ->
    @_show_popover(title, text)
    @_visible = true

  @hide = ->
    NotifySound.stop()
    @_hide_popover()
    @_visible = false

  @_show_popover = (title, text) ->
    $('#talk-notify').popover('destroy')
    $('#talk-notify').attr('data-content', text)
    $('#talk-notify').attr('data-original-title', title + $('.notify-sound-toggler-form').html() + @close_button_template)
    $('#talk-notify').popover('show')

  @_hide_popover = ->
    $('#talk-notify').popover('hide')

  @close_button_template = '
    <button id="hide-notify" class="btn btn-unstyled ignoredirty">
      <i class="icon icon-remove-sign" style="width: 20px"></i>
    </button>
  '

App.NotifyWindow = NotifyWindow

$(document).on 'click', '#hide-notify', ->
  App.NotifyWindow.hide()
  # Stop Event Propagation
  false
