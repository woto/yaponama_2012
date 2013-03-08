$ ->
  $(".hover-profileable").hover ->
    $(this).find(".plus-profileable").show()
  , ->
    $(this).find(".plus-profileable").hide()
