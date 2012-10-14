$(document).ready ->
  $("#cars").bind "cocoon:before-insert", (event, data) ->
    tab_1 = Math.floor((Math.random()*10000000000)+1)
    tab_2 = Math.floor((Math.random()*10000000000)+1)
    $(this).find("#tab1").attr("id", "tab1_" + tab_1)
    $(this).find("#tab2").attr("id", "tab2_" + tab_2)
    $(this).find(".tab1_toggle").attr("href", "#tab1_" + tab_1)
    $(this).find(".tab2_toggle").attr("href", "#tab2_" + tab_2)
    $(data).css('background', '#666')

  $("#requests_with_auto").bind "cocoon:before-insert", (event) ->
    event.stopPropagation()

