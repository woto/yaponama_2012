window.Application ||= {}

$ ->


Application.showLoading = ->
  Application.toTop();
  $("#loading").css "top", (parseInt(($(window).height() - $("#loading").innerHeight() - $(window).height()/2 )/2, 10)) + "px"
  $("#loading").css "left", parseInt(($(window).width() - $("#loading").innerWidth())/2, 10) + "px"
  $("#loading").show()
  $("#search-area-parent").animate({ opacity: 0 })

$(".ajax-search").on "click", ->
  Application.showLoading()
