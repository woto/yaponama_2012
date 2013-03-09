$(document).on 'page:load', ->
  profileables_buttons()

$ ->
  profileables_buttons()

profileables_buttons = ->
  $(".hover-profileable").hover ->
    $(this).find(".plus-profileable").show()
  , ->
    $(this).find(".plus-profileable").hide()

  $('.profileable-item').hover ->
    $(this).find('.profileable-item-control').show()
  , ->
    $(this).find('.profileable-item-control').hide()
