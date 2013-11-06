window.Application ||= {}

$ ->

Application.toTop = ->
  $("html, body").animate({scrollTop: 0}, 'fast')

Application.showLoading = ->
  Application.toTop();
  #$("#loading").css "top", (parseInt(($(window).height() - $("#loading").innerHeight() - $(window).height()/2 )/2, 10)) + "px"
  #$("#loading").css "left", parseInt(($(window).width() - $("#loading").innerWidth())/2, 10) + "px"
  $("#loading").show()
  $("#search-area-parent").animate({ opacity: 0 })

Application.hideLoading = ->
  $("#loading").hide()
  $("#search-area-parent").animate({ opacity: 100 })

$(document).on "click", ".ajax-search", ->
  Application.showLoading()

$(document).on "submit", ".ajax-form", ->
  Application.showLoading()

$(document).on "page:receive", ->
  Application.hideLoading()
