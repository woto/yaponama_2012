$(document).on 'click', '.collapse-reset-checkboxes', ->
  $target = $(this).closest("[rel='collapse-next']").next()
  $target.find('.element').attr('checked', false)

$(document).on 'click', '.collapse-reset-range', ->
  $target = $(this).closest("[rel='collapse-next']").next()
  $target.find('.element').val([0, 10000])

$(document).on
  mouseenter: (event) ->
    #alert $(this).data('load')

    $(event.target).data
      content: 'zzz'
      title: 'b TODO TODO TODO TODO bb'
      placement: 'left'

    $(event.target).popover 'show'

  mouseleave: (event) ->
    $(event.target).popover 'hide'
, ".opts-help"
