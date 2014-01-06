App = exports ? this

$(document).on 'change', '.talk_read', ->
  #$('#edit_talk_placeholder').attr('action',  '/admin/talks/' + $(this).data('id'))
  #$('#talk_read_placeholder').prop('checked', $(this).is(':checked'))
  $(this).closest('form').trigger("submit.rails")

#$(document).on "ajax:success", "#new_talk", (e, data, status, xhr) ->
#  CKEDITOR.instances.talk_talkable_attributes_content.setData('')
#  CKEDITOR.instances.talk_talkable_attributes_content.resetDirty()

#$(document).on 'ajax:success', (e, data, status, xhr) ->
#  if $(e.target).is('#new_talk')
#    $('#talk-log').prepend( SHT['talks/talk'](data) )


  #cached_talk_send = ->
  #  jqxhr = $.post "/user/pretype", { user: { cached_talk: $('#talk_talkable_attributes_content').val() } }
  #
  #debounced_cached_talk_send = _.debounce(cached_talk_send, 1000)
  #
  ## Изменилось TODO Переделать, способ ясен
  #$(document).on 'propertychange keyup input paste change',  '#new_talk', ->
  #  debounced_cached_talk_send()


# При добавлении типа файл переинициализируем все fileupload
$(document).on 'cocoon:after-insert', '#new_talk', (e, insertedItem) ->
  App.init_jquery_file_upload()
