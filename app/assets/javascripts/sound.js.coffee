submit = ->
  $('#sound-form').trigger('submit.rails')

debounce = _.debounce(submit, 500);

$(document).on 'click', '#sound', (event) ->
  $(event.currentTarget).find(':checkbox').prop('checked', $(event.currentTarget).hasClass('active'))
  debounce()
