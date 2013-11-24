#App = exports ? this
window.Application ||= {}
Application.client = new Faye.Client('/faye');

$ ->

  Application.client.on 'transport:down', ->
    console.log 'transport:down'

  Application.client.on 'transport:up', ->
    console.log 'transport:up'

  Application.client.subscribe "/messages/" + $('#current_user_id').text(), (message) ->
    alert message
