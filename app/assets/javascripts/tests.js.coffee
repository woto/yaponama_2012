##_.delay (->
##  console.log $(this).val(instance.getData());
##), 1000, "logged later"

makeEditable = ->
  $('.editable').each ->
    $(this).attr('contenteditable', 'true')
    CKEDITOR.inline(this, window.extended_options);
    $(this).editableHighlight()
    #this.focus()

$(document).on 'click', '#edit', (e) ->
  e.preventDefault()
  CKEDITOR.disableAutoInline = true;
  makeEditable()

$(document).on 'click', '#save', -> 
  data = CKEDITOR.instances.editable.getData();
  #alert(data);
  $('#content').val(data)
  $(CKEDITOR.instances.editable.element.$).editableHighlight()
  CKEDITOR.instances.editable.destroy()
  $('.editable').removeAttr('contenteditable')
  #CKEDITOR.instances.editable.resetDirty()

# TODO из-за того, что ckeditor загружаю через jQuery getScript это перестало быть работоспособным
#CKEDITOR.disableAutoInline = true;
#
#


$(document).on 'socket.joined', (e) ->

  window.socket.on "rails.stats.create", (msg) ->
    console.log $.parseJSON(msg)

  window.socket.on "rails.calls.create", (msg) ->
    console.log $.parseJSON(msg)

  window.socket.on "rails.geo1.create", (msg) ->
    console.log $.parseJSON(msg)
