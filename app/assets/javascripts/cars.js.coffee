$(document).on "cocoon:before-insert", "#cars", (event, data) ->
  tab_1 = Math.floor((Math.random()*10000000000)+1)
  tab_2 = Math.floor((Math.random()*10000000000)+1)
  data.find("#tab1").attr("id", "tab1_" + tab_1)
  data.find("#tab2").attr("id", "tab2_" + tab_2)
  data.find("#tab1_toggle").attr("href", "#tab1_" + tab_1)
  data.find("#tab2_toggle").attr("href", "#tab2_" + tab_2)
