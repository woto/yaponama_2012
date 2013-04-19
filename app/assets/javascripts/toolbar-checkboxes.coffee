$(document).on 'click', '#check-uncheck-items', ->
  $('input.item[type=checkbox]').prop('checked', $(this).prop('checked') )
  update()

$(document).on 'click', '#check-items', (e) ->
  e.preventDefault()
  $('input.item[type=checkbox]').prop('checked', true)
  update()

$(document).on 'click', '#uncheck-items', (e) ->
  e.preventDefault()
  $('input.item[type=checkbox]').prop('checked', false)
  update()

$(document).on 'change', 'input.item[type=checkbox]', ->
  update()

update = ->

  form = $("#new_grid")
  items = $('#items')

  $('<input>').attr({
      type:  'hidden'
      name:  'items'
      value: ''
  }).appendTo(items)

  form.trigger("submit.rails")  

#$(document).on 'page:restore', -> 
#  alert('page:restore')
#  update(false)
# Конечно прикольней сделать в онлайне, 
# поэтому чтобы не усложнять пока вообще уберу

# К сожалению через data-dismiss="modal" либо не сабмитится и скрывается модальное окно
# либо сабмитится, но backdrop не пропадает
$(document).on 'submit', '#new_grid', ->
  $('.modal').modal('hide')
