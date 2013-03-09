$(document).on 'page:load', ->
  profileables_buttons()

$ ->
  profileables_buttons()

profileables_buttons = ->
  $(".hover-profileable").hover ->
    $(this).find(".plus-profileable").css("visibility", "visible")
  , ->
    $(this).find(".plus-profileable").css("visibility", "hidden")

  $('.profileable-item').hover ->
    $(this).find('.profileable-item-control').css("visibility", "visible")
  , ->
    $(this).find('.profileable-item-control').css("visibility", "hidden")
