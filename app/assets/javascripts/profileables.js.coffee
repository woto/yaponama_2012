$ ->
  profileables_buttons()

profileables_buttons = ->
  $(".profileable-category").hover ->
    $(this).find(".profileable-category-add").css("visibility", "visible")
  , ->
    $(this).find(".profileable-category-add").css("visibility", "hidden")

  $('.profileable-item').hover ->
    $(this).find('.profileable-item-controls').css("visibility", "visible")
  , ->
    $(this).find('.profileable-item-controls').css("visibility", "hidden")

# Странно, пробовал заменить с помощью mouseenter и mouseleave с событием 
# на document - на компьютере работает, а на iPhone нет.
#
# $(document).on
#   mouseenter: ->
#     $(this).find(".profileable-category-add").css("visibility", "visible")
#   mouseleave: ->
#     $(this).find(".profileable-category-add").css("visibility", "hidden")
# , '.profileable-category'
# 
# $(document).on
#   mouseenter: ->
#     $(this).find('.profileable-item-controls').css("visibility", "visible")
#   mouseleave: ->
#     $(this).find('.profileable-item-controls').css("visibility", "hidden")
# , '.profileable-item'
