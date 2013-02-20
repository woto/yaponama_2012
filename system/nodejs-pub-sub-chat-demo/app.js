var app = require('http').createServer(handler),
	io = require('socket.io').listen(app),
	fs = require('fs');

var redis = require("redis"),
  client = redis.createClient();
	
	app.listen(80); //, "192.168.178.34");
	
  var tmp = '';

	function handler(req, res) { // just return index.html
    res.writeHead(200);
    res.write(tmp)
    res.end();

    /*
		fs.readFile(__dirname + '/index.html',
			function (err, data) {
				if (err) {
					res.writeHead(500);
					return res.end('Error loading index.html');
				}
				
				res.writeHead(200);
				res.end(data);
			});
      */
	}

	io.sockets.on('connection', function (socket) { // handler for incoming connections

    socket.on('page', function(data){
			var msg = JSON.parse(data);
      //client.set('page', msg.html);
      //var reply = JSON.stringify({})
			var reply = JSON.stringify({action: 'page', user: msg.user, time: msg.time, html: msg.html });
			socket.emit('page', reply);
			socket.broadcast.emit('page', reply);
    });

    socket.on('size', function(data){
			var msg = JSON.parse(data);
			var reply = JSON.stringify({action: 'size', user: msg.user, width: msg.width, height: msg.height, auth_token: msg.auth_token });
			socket.emit('size', reply);
			socket.broadcast.emit('size', reply);
    });

    socket.on('scroll', function(data){
			var msg = JSON.parse(data);
			var reply = JSON.stringify({action: 'scroll', user: msg.user, x: msg.x, y: msg.y });
			socket.emit('scroll', reply);
			socket.broadcast.emit('scroll', reply);
    });

    socket.on('cursor', function(data){
			var msg = JSON.parse(data);
			var reply = JSON.stringify({action: 'cursor', user: msg.user, page: {x: msg.page.x, y: msg.page.y}, client: {x: msg.client.x, y: msg.client.y} });
			socket.emit('cursor', reply);
			socket.broadcast.emit('cursor', reply);
    });

		socket.on('chat', function (data) {
			var msg = JSON.parse(data);
			var reply = JSON.stringify({action: 'message', user: msg.user, msg: msg.msg });
			socket.emit('chat', reply);
			socket.broadcast.emit('chat', reply);
		});

		socket.on('join', function(data) {
			var msg = JSON.parse(data);
			var reply = JSON.stringify({action: 'control', user: msg.user, msg: ' joined the channel' });
			socket.emit('chat', reply);
			socket.broadcast.emit('chat', reply);
		});

    socket.on('disconnect', function () {
			var reply = JSON.stringify({action: 'control', user: 'somebody', msg: ' disconnects the channel' });
      socket.emit('chat', reply);
			socket.broadcast.emit('chat', reply);
    });
	});
