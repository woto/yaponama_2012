handler = (req, res) ->
  res.writeHead 200
  res.write tmp
  res.end()

app = require("http").createServer(handler)
io = require("socket.io").listen(app)
fs = require("fs")
rs = require("redis")

sub = rs.createClient()
app.listen 80

sockets = []

io.sockets.on "connection", (socket) ->

sub.on "pmessage", (channel, msg, data) ->
  console.log msg
  console.log channel
  console.log data

  switch msg

    # TODO Его уже нет. теперь эти поля в юзер, позже подумаю как надо
    when 'rails.geo1.create'
      clients = io.sockets.clients()
      for client in clients
        client.emit msg,
          data
      break

    when "rails.calls.create"
      clients = io.sockets.clients()
      for client in clients
        client.emit msg,
          data
      break

    when "rails.stats.create"
      clients = io.sockets.clients()
      for client in clients
        client.emit msg,
          data
      break

    when "d"
      console.log 'a'


sub.psubscribe "*"
