start = ->
  $('#items-progress').show()

stop = ->
  $('#items-progress').hide()

$(document).on "ajax:success", "#new_talk", (e, data, status, xhr) ->
  CKEDITOR.instances.talk_talkable_attributes_content.setData('')
  CKEDITOR.instances.talk_talkable_attributes_content.resetDirty()
  $("#talk-log-holder").nanoScroller({ scroll: 'top' });

$(document).on "ajax:beforeSend", (xhr, settings) ->
  if $(xhr.target).closest('#new_grid').length > 0
    start()

$(document).on "ajax:complete", (xhr, status) ->
  if $(xhr.target).closest('#new_grid').length > 0
    stop()

$(document).on 'ajax:success', (e, data, status, xhr) ->
  if $(e.target).is('#new_talk')
    $('#talk-log-inner').prepend( SHT['talks/talk'](data) )
