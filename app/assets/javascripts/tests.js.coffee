#_.delay (->
#  console.log $(this).val(instance.getData());
#), 1000, "logged later"

$ ->
  makeEditable()

$(document).on 'page:load', (e) ->
  makeEditable()

makeEditable = ->
  $('.editable').each ->
    $(this).attr('contenteditable', 'true')
    CKEDITOR.inline(this);

$(document).on 'click', '#save', -> 
  data = CKEDITOR.instances.editable.getData();
  #alert(data);
  $('#content').val(data)
  CKEDITOR.instances.editable.resetDirty()


CKEDITOR.disableAutoInline = true;
