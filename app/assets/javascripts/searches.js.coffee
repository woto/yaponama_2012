window.Application ||= {}

$ ->

Application.toTop = ->
  $("html, body").animate({scrollTop: 0}, 'fast')

Application.showLoading = ->
  Application.toTop();
  # TODO Потом разберусь с позиционированием, сейчас вполне устраивает в левом верхнему углу
  #$("#loading").css "top", (parseInt(($(window).height() - $("#loading").innerHeight() - parseInt($(window).height()/2, 10) )/2, 10)) + "px"
  #$("#loading").css "left", parseInt(($(window).width() - $("#loading").innerWidth() - parseInt($(window).width()/2, 10))/2, 10) + "px"
  $("#loading").show()
  $("#main").animate({ opacity: 0 })

Application.hideLoading = ->
  $("#loading").hide()
  $("#main").animate({ opacity: 100 })

$(document).on "click", ".ajax-search", ->
  Application.showLoading()

$(document).on "submit", ".ajax-form", ->
  Application.showLoading()

$(document).on "page:receive", ->
  Application.hideLoading()
