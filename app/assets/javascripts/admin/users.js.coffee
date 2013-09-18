$(document).on
  mouseenter: ->
    $(this).find(".profileable-category-add").css("visibility", "visible")
  mouseleave: ->
    $(this).find(".profileable-category-add").css("visibility", "hidden")
, '.profileable-category'

$(document).on
  mouseenter: ->
    $(this).find('.profileable-item-controls').css("visibility", "visible")
  mouseleave: ->
    $(this).find('.profileable-item-controls').css("visibility", "hidden")
, '.profileable-item'
