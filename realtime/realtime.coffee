util = require 'util'
colors = require 'colors'
pg = require 'pg' 
async = require 'async'
yaml = require 'js-yaml'
http = require 'http'
sockjs = require 'sockjs'
fs = require 'fs'
rs = require 'redis'
_ = require('underscore')._

App = exports ? this

# Читаем RAILS_ENV
rails_env = process.env.RAILS_ENV || 'development'

# Настраиваем SockJS
sjs = sockjs.createServer()
server = http.createServer()
sjs.installHandlers server, prefix: "/realtime"

# Читаем database.yml
#console.log fs.realpathSync
database_file = fs.readFileSync(__dirname + '/../config/database.yml', 'utf8')
database_yml = yaml.load(database_file)[rails_env];
console.log(util.inspect(database_yml, false, 10, true));
pg.defaults.user = database_yml['username']
pg.defaults.database = database_yml['database']
pg.defaults.password = database_yml['password'] || undefined
pg.defaults.host = database_yml['host'] || '/var/run/postgresql/'
pg.defaults.port = database_yml['port'] || 5432

# Инициализируем клиента PostgreSQL
db = new pg.Client()

users = {}
connections = {}
sellers = {}

async.waterfall [(callback) ->

  # Подключаемся к PostgreSQL
  db.connect (err) ->
    
    if err?
      callback err
    else
      callback null

, (callback) ->

  # Делаем всех пользователей оффлайн
  query = "UPDATE somebodies SET online = false"
  db.query query, (err, result) ->

    if err?
      callback err
    else
      callback null

, (callback) ->

  # Получаем настройки сайта
  query = "SELECT * from admin_site_settings"
  db.query query, (err, result) ->

    if err?
      callback err
    else if result.rows.length != 1
      # Пригождается в случае запуска Rails тестов
      callback null, require('../config/config.yml')[rails_env];
      #callback query
    else
      callback null, result.rows[0]

, (config, callback) ->

  # Запускаем веб сервер
  server.listen parseInt(config.realtime_port, 10), '0.0.0.0'

  # Подключаемся к Redis
  sub = rs.createClient(config.redis_port, config.reds_host)

  process.stdout.write("\n\nREADY\n\n")

  sjs.on "connection", (conn) ->

    conn.send = (message, data) ->

      to_send =
        message: message
        data: data

      console.log 'SockJS SEND'.grey
      console.log to_send
      console.log ''
      @write JSON.stringify(to_send)

    user_id = undefined
    auth_token = undefined

    conn.on 'data', (data) ->

      console.log 'SockJS RECV'.grey
      console.log data
      console.log ''

      data = JSON.parse(data)

      async.series [(callback) ->

        switch data.message

          when 'request sellers'

            # Если sellers еще не заполнен, то заполняем и 
            # из update_sellers бродкастится
            unless _.some(sellers)
              update_sellers (err) ->
            else
              conn.send "response sellers", sellers

          when 'request authentication'

            # Сохраняем auth_token
            auth_token = data.data

            async.waterfall [(callback) ->

              # Сохраняем user_id, полученный из auth_token
              query = "SELECT * FROM somebodies WHERE auth_token=$1 LIMIT 1"
              db.query query, [auth_token], (err, result) ->

                if err?
                  callback err
                else if result.rows.length != 1
                  callback query
                else
                  callback null, result.rows[0]

            , (row, callback) ->

                # Сохраняем сопоставление id сессии - инстанс сессии
                connections[conn.id] = conn

                user_id = row.id.toString()

                # Если пользователь с таким user_id уже подключен
                # Добавляем текущему пользователю в список его сессий
                # с которых он подключен текущую сессию
                if users[user_id]
                  users[user_id]['connections'] = _.union(users[user_id]['connections'], [conn.id])
                  callback null

                # Иначе
                else

                  async.waterfall [(callback) ->

                    # и запоминаем в users
                    result = App.get_user_data row
                    users[user_id] = _.extend(result, { connections: [conn.id] })
                    callback null


                  , (callback) ->

                    # делаем этот user_id online
                    query = "UPDATE somebodies SET online = true where id=$1 AND online = false"
                    db.query query, [user_id], (err, result) ->

                      if err?
                        callback err
                      else if result.rowCount != 1
                        callback query
                      else
                        callback null

                  ], (err) ->

                    if err?
                      callback err
                    else
                      callback null

            , (callback) ->

              if users[user_id].role == 'seller'
                update_sellers (err) ->

                  if err?
                    callback err
                  else
                    callback null

              else
                callback null

            ], (err, results) ->

              if err?
                conn.end()
                callback err
              else
                conn.send 'response authentication', 'success'

              callback null
        
      ], (err, results) ->

        if err?
          console.log 'ERROR'.cyan
          console.log err
          console.log ''
          #process.exit()
        else
          debug_globals()

    conn.on "close", ->

      _.delay (->

        if users[user_id]

          users[user_id]['connections'] = _.without(users[user_id]['connections'], conn.id)

          delete connections[conn.id]

          async.waterfall [(callback) ->

            if users[user_id]['connections'].length == 0

              async.waterfall [(callback) ->

                query = "UPDATE somebodies SET online = false where id=$1 AND online = true"
                db.query query, [user_id], (err, result) ->

                  if err?
                    callback err

                  if result.rowCount > 0 && users[user_id].role == 'seller'
                    update_sellers (err) -> 

                      if err?
                        callback err
                      else
                        callback null

                  else
                    callback null

              , (callback) ->

                delete users[user_id]
                callback null

              ], (err, result) ->

                if err?
                  callback err
                else
                  callback null

            else
              callback null

          ], (err, result) ->

            debug_globals()

      ), 0

  sub.on "pmessage", (channel, msg, data) ->
    data = JSON.parse(data)
    console.log 'Redis RECV'.grey
    console.log 'channel:'.grey, channel
    console.log 'msg:'.grey, msg
    console.log 'data:'.grey, data
    console.log ''

    switch msg

      when rails_env + ':update sellers'
        update_sellers (err) ->
          callback err if err?

      when rails_env + ':show talk'

        # Мы хотим отправлять сообщение только на все устройства уникальных юзеров
        user_ids = [data.somebody_id, data.creator_id, data.addressee_id]
        user_ids = user_ids.concat(sellers.map (seller) -> seller.id)
        user_ids = _.compact(_.uniq(user_ids))
        
        for user_id in user_ids
          if users[user_id]?
            for connection_id in users[user_id].connections
              connections[connection_id].send 'show talk', data

  sub.psubscribe rails_env + ":*"

], (err, config) ->
  console.error err
  process.exit()

update_sellers = (callback) ->

  query = 'SELECT "somebodies".*, "deliveries_places"."name" as "place" FROM "somebodies" LEFT OUTER JOIN "deliveries_places" ON "deliveries_places"."id" = "somebodies"."place_id" WHERE "somebodies"."role" IN (\'manager\', \'admin\') ORDER BY "somebodies"."id" ASC'

  db.query query, (err, result) ->

    if err?
      callback err
    else
      sellers = _.map result.rows, (seller) ->
        App.get_user_data seller

      broadcast_sellers()

      callback null

broadcast_sellers = ->

  for connection_id, connection of connections
    connection.send 'response sellers', sellers

App.get_user_data = (row) ->

  cached_profile = JSON.parse(row.cached_profile)
  id = row.id
  post = row.post
  name = cached_profile?.names?[0]?['name']
  surname = cached_profile?.names?[0]?['surname']
  patronymic = cached_profile?.names?[0]?['patronymic']
  phone = cached_profile?.phones?[0]?['value']
  online = row.online

  # Роль
  if row.role in ['manager', 'admin']
    role = 'seller'
  else
    role = 'buyer'

  place = row.place

  data =
    id: id
    place: place
    post: post
    name: name
    surname: surname
    patronymic: patronymic
    phone: phone
    role: role
    online: online

  data

debug_globals = ->

  data = 
    users: users
    connections: _.keys(connections)
    sellers: sellers

  console.log 'DEBUG'.grey
  console.log data
  console.log ''

  #for connection_id, connection of connections
  #  data = 
  #    users: users
  #    connections: _.keys(connections)
  #    sellers: sellers

  #  connection.send data
