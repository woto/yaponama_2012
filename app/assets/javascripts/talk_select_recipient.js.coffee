App = exports ? this

App.select_addressee = ->
  #$('#talk_addressee_id').val('')
  $('#i-want-to-choose-seller-block').hide()
  $('#i-dont-want-to-choose-seller-block').show()
  Realtime.render_sellers_2()
  $('#talk-recipients').show()

App.unselect_addressee = ->
  $('#talk_addressee_id').val('')
  $('#talk-recipients').hide()
  $('#i-want-to-choose-seller-block').show()
  $('#i-dont-want-to-choose-seller-block').hide()

$(document).on 'click', '#i-want-to-choose-seller', (e) ->
  e.preventDefault()
  App.select_addressee()

$(document).on 'click', '#i-dont-want-to-choose-seller', (e) ->
  e.preventDefault()
  App.unselect_addressee()

$(document).on 'click', '.select-addressee', (e) ->
  e.preventDefault()
  $('#talk_addressee_id').val($(this).data('id'))
  Realtime.render_sellers_2()
  $('.concrete-seller').effect('highlight')
