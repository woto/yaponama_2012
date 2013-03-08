$(document).on 'page:load', ->
  add_profileables_button()

$ ->
  add_profileables_button()

add_profileables_button = ->
  $(".hover-profileable").hover ->
    $(this).find(".plus-profileable").show()
  , ->
    $(this).find(".plus-profileable").hide()
