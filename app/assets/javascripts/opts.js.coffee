$(document).on 'click', '.collapse-reset-checkboxes', ->
  $target = $(this).closest("[rel='collapse-next']").next()
  $target.find('.element').attr('checked', false)

$(document).on 'click', '.collapse-reset-range', ->
  $target = $(this).closest("[rel='collapse-next']").next()
  $target.find('.element').val([0, 10000])
