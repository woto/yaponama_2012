fs = require('fs')
util = require('util')
async = require('async')
_ = require('underscore')

phantom.onError = (msg, trace) ->
  null


class Crawler
  constructor: (conf) ->

    @urls = []

    @queue = async.queue((task, callback) =>

      console.log task.url

      page = require('webpage').create
        resourceTimeout: 15000

      page.onResourceError = (error) ->
        null
        #console.log error
      page.onError = (error) ->
        null
        #console.log error
      page.onConsoleMessage = (error) ->
        null
        #console.log error


      fullpath = conf.host + encodeURI(task.url)

      page.open fullpath, (status) =>
        #console.log fullpath
        console.log @queue.length()
        #console.log status

        if status == 'success'
          conf.success page, task.url, =>

            # Получаем все ссылки на странице
            urls = page.evaluate ->
              Array::slice.call(document.querySelectorAll("a"), 0).map (link) ->
                link.getAttribute "href"

            #console.log(util.inspect(urls, false, 10, true));
            #phantom.exit()

            for url in urls
              if !(/^\/ru\/parts\/search/.test(url)) && !(/^#/.test(url)) && !(/^\/files/.test(url)) && !(/^\/img/.test(url)) && !(/^http:\/\//.test(url)) && !(/^javascript:/.test(url))

                url = url.replace(conf.host, '')

                unless /^\//.test(url)
                  url = '/' + url

                #console.log(util.inspect(url, false, 10, true));
                #phantom.exit()

                if url not in @urls
                  @urls.push url
                  
                  @start url

            page.close()
            callback()

            #console.log(util.inspect(urls, false, 10, true));


        else
          conf.failure page, task.url, =>
            page.close()
            callback()
      null

    , 5)


  start: (url, callback) =>
    @queue.push
      url: decodeURI(url)
    , (err) ->
      #console.log err
      #console.log "finished processing foo"


  crawl: (args) ->

    #success = args.success
    #failure = args.failure

    #async.waterfall [(callback) =>

    #  @page.open @host + url, (status) =>
    #    callback null, @page, url, status

    #, (page, url, status, callback) =>

    #  # Вызываем Callback в зависимости от результата
    #  if status == 'success'
    #    success page, url, status, =>

    #      # Получаем все ссылки на странице
    #      urls = page.evaluate ->
    #        Array::slice.call(document.querySelectorAll("a"), 0).map (link) ->
    #          link.getAttribute "href"

    #      # И фильтруем в соответствии с правилом
    #      # TODO Позже продумать с depth
    #      urls = urls.filter(@filter)
    #      urls = _.uniq(urls)

    #      urls = _.difference(urls, @all_urls);

    #      for url in urls
    #        @crawl
    #          url: url
    #          success: success
    #          failure: failure

    #      #@all_urls = @all_urls.concat(urls)
    #      #@all_statuses = new Array(urls.length).map(->
    #      #  false
    #      #)

    #      #console.log(util.inspect(urls, false, 10, true));

    #      callback null, page, url, status
    #  else
    #    failure page, url, status, ->
    #      callback null, page, url, status

    #, (page, url, status, callback) =>

    #  #index = @all_urls.indexOf(url)
    #  #@all_statuses[index] = true

    #  #
    #  #if @all_statuses.indexOf(false) > -1
    #  #  @all_urls

    #  #async.eachSeries @all_urls, ((item, callback) ->
    #  #  self.crawl "http://www.avtorif.ru" + item, depth, onSuccess, onFailure, callback
    #  #), (err) ->

    #  #  console.log 'done ' + @all_statuses.length
    #  #  phantom.exit()

    #  #  #if _.every(@all_statuses)
    #  #  #  console.log 'done ' + @all_statuses.length
    #  #  #  phantom.exit()
    #  #  #else

    #  #  #  #index = @all_urls.indexOf(url)

    #  #  #  #phantom.exit()
    #  #  #  @crawl
    #  #  #    url: '/' 
    #  #  #    success: success
    #  #  #    failure: failure
    #]


crawler = new Crawler 

  host: "http://192.168.100.14"

  success: (page, url, callback) ->
    post = require('webpage').create()
    server = 'http://localhost/admin/pages'

    content = page.evaluate(->
      #if document.body and document.body.innerHTML then document.body.innerHTML else ""
      if document.body and document.body.querySelector('#main') then  document.body.querySelector('#main').innerHTML else ""
    )

    title = page.evaluate(->
      if document.title then document.title else ""
    )

    #console.log content
    data = "page[title]=" + encodeURIComponent(title) + "&page[path]=" + encodeURIComponent(url) + "&page[content]="+ encodeURIComponent(content)

    post.open server, "post", data, (status) ->
      post.close()
      #console.log 'success - ' + url
      callback null, page, url

    null

  failure: (page, url, callback) ->
    #console.log "failure - " + url
    callback null, page, url

crawler.start '/', ->
  phantom.exit()
