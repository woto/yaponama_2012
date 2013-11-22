colors = require 'colors'
pg = require 'pg' 
async = require 'async'
require 'js-yaml'
http = require 'http'
sockjs = require 'sockjs'
fs = require 'fs'
rs = require 'redis'
_ = require('underscore')._

sjs_talk = sockjs.createServer()
server = http.createServer()
sjs_talk.installHandlers server, prefix: "/talk"

rails_env = process.env.RAILS_ENV || 'development'

doc = require('../config/database.yml')[rails_env];

pg.defaults.user = doc['username']
pg.defaults.database = doc['database']
pg.defaults.password = doc['password'] || undefined
pg.defaults.host = doc['host'] || '/var/run/postgresql/'
pg.defaults.port = doc['port'] || 5432

db = new pg.Client()

users = {}
rooms = {}
connections = {}

db.connect (err) ->
  #console.log err if err?
  db.query "SELECT * from admin_site_settings", (err, result) ->
    #console.log err if err?
    config = result.rows[0]

    debugger
    server.listen parseInt(config['socket_io_port'], 10), config['socket_io_address']
    sub = rs.createClient(config['redis_port'], config['reds_host'])

    sjs_talk.on "connection", (conn) ->

      user_id = undefined
      auth_token = undefined

      conn.on 'data', (data) ->

        data = JSON.parse(data)

        switch data.message

          when 'join room'

            if user_id && auth_token

              # Разрешаем подключиться к любой комнате только если роль seller или только к собственной
              if users[user_id]['role'] == 'seller' || user_id == data['payload']['room'].toString()

                room = data['payload']['room'].toString()

                # Если комната, к которой мы присоединяемся существует
                if rooms[room]

                  # Добавляем этого пользователя в список пользователей комнаты
                  rooms[room]['users'] = _.union(rooms[room]['users'] || [], [user_id])

                else
                  # Иначе создаем комнату и сажаем туда текущую сессию
                  rooms[room] = 
                    users: [user_id]

                # Добавляем эту комнату к списку комнат, в которых присутствует этот пользователь
                users[user_id]['rooms'] = _.union(users[user_id]['rooms'] || [], [room])

                # И обновляем резидентов комнаты, к которой присоединились
                update_residents room, "Вы присоединились к новой комнате, отправляем всем пользователям в этой комнате об изменении состава комнаты."

              debug_globals()

          when 'authenticate'

            # Сохраняем auth_token
            auth_token = data.payload

            async.series [(callback) ->
              db.query "SELECT id FROM somebodies WHERE auth_token=$1", [auth_token], (err, res) ->
                # Получаем user_id из auth_token'a и сохраняем
                user_id = res.rows[0].id.toString()
                callback null
            , (callback) ->
              async.series [(callback) ->
                # Если пользователь с таким user_id уже подключен
                if users[user_id]?
                  for room in users[user_id]['rooms']
                    # Добавляем текущему пользователю в список его сессий
                    # с которых он подключен текущую сессию
                    users[user_id]['connections'] = _.union(users[user_id]['connections'], [conn.id])
                  callback null
                else
                  # Иначе делаем этот user_id online
                  db.query "UPDATE somebodies SET online = true where id=$1", [user_id]

                  # Получаем роль клиента
                  db.query "SELECT * from somebodies where id=$1", [user_id], (err, res) ->

                    cached_main_profile = JSON.parse(res.rows[0].cached_main_profile)
                    debugger

                    place_id = res.rows[0].deliveries_places_place_id
                    post = res.rows[0].post
                    name = cached_main_profile?.names?[0]?['name']
                    phone = cached_main_profile?.phones?[0]?['phone']

                    async.series [(callback) ->

                      if place_id?
                        db.query "SELECT * FROM deliveries_places_places WHERE id=$1", [place_id], (err, res) ->
                          callback err, res.rows[0].name
                      else
                        callback null, null

                        #, (callback) ->
                        #  
                        #  callback null, aaa

                    ], (err, results) ->

                      place = results[0]

                      if res.rows[0].role in ['manager', 'admin']
                        role = 'seller'
                      else
                        role = 'buyer'

                      # Инициализирум users
                      users[user_id] = 
                        name: name
                        phone: phone
                        role: role
                        connections: [conn.id]
                        post: post
                        # TODO Возможно лучше потом переименовать в place или location
                        place: place

                      callback null

              ], (err, results) ->

                # Сохраняем сопоставление id сессии - инстанс сессии
                connections[conn.id] = conn

                debug_globals()

                data =
                  message: 'authenticated'

                 conn.write JSON.stringify(data)

            ]

      debug_globals = ->
        for connection in _.values(connections)
          data = 
            users: users
            rooms: rooms
            connections: _.keys(connections)
          connection.write JSON.stringify(data)

      update_residents = (room, debug) ->
        for user in rooms[room]['users']
          for connection_id in users[user]['connections']
            data =
              message: 'update residents'
              comment: debug
              room: room
              # Заменить на users (?)
              residents: _.map(rooms[room]['users'], (user_id) ->
                users[user_id]
              )
               

            connections[connection_id].write JSON.stringify(data)

      conn.on "close", ->

        _.delay (->

          users[user_id]['connections'] = _.without(users[user_id]['connections'], conn.id)
          delete connections[conn.id]

          if users[user_id]['connections'].length == 0

            for room in users[user_id]['rooms']
              rooms[room]['users'] = _.without(rooms[room]['users'], user_id)

              if rooms[room]['users'].length == 0
                delete rooms[room]
              else
                update_residents room, "За пользователем больше не осталось соединений, но комнаты в которых он присутсвовал еще живы, оповещаем всех оставшихся пользователей в них"

            delete users[user_id]

            db.query "UPDATE somebodies SET online = false where id=$1", [user_id]

            #else

            #  for room in users[user_id]['rooms']
            #    update_residents room, "За пользователем еще остались закрепленные соединения. Возможно это не нужно."

          debug_globals()

        ), 5000

    message_to_room = (room, talk) ->
      debugger
      for user in rooms[room]['users']
        for connection_id in users[user]['connections']
          data =
            message: 'new talk'
            comment: ''
            room: room
            talk: talk

          connections[connection_id].write JSON.stringify(data)

    sub.on "pmessage", (channel, msg, data) ->
      #console.log msg
      #console.log channel
      #console.log data

      switch msg

        when 'talk'
          debugger
          data = JSON.parse(data)
          message_to_room(data['user_id'], data)

          #when 'daskfhlqwefuihg'
          #  room = JSON.parse(data)['auth_token']
          #  clients = io.sockets.in(room).emit 'talk',
          #    data
          #  break

          ## TODO Его уже нет. теперь эти поля в юзер, позже подумаю как надо
          #when 'rails.geo1.create'
          #  clients = io.sockets.clients()
          #  for client in clients
          #    client.emit msg,
          #      data
          #  break

          #when "rails.calls.create"
          #  clients = io.sockets.clients()
          #  for client in clients
          #    client.emit msg,
          #      data
          #  break

          #when "rails.stats.create"
          #  clients = io.sockets.clients()
          #  for client in clients
          #    client.emit msg,
          #      data
          #  break

          #when "d"
          #  console.log 'a'


    sub.psubscribe "*"
