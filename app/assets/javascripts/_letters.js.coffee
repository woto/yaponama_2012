init = ->
  $(document).on 'click', '#letter-type a', (e) ->
    e.preventDefault()
    $(this).tab('show');

$ ->
  init()

$(document).on 'page:load', ->
  init()
