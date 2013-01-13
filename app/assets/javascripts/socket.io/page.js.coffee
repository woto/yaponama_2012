if self == top

  $ ->
    send_data()

  $(document).on 'page:change', (e) ->
    send_data()

  send_data = ->
    window.socket.emit 'page', $.toJSON(
      time: new Date(),
      html: '<!DOCTYPE html><html lang="ru">' +  $("html").html() + '</html>'
    )

  window.socket.on "page", (msg) ->
    message = $.evalJSON(msg)
    action = message.action
    switch action
      when "page"
        #$('#iframe').attr('src', 'http://192.168.2.7:8080/admin/users')
        #$('#iframe').html = msg.html
        #iFrameDoc = $('#iframe')[0].contentDocument || $('#iframe')[0].contentWindow.document;
        #iFrameDoc.write(message.html);
        #
        #$('#iframe').contents()[0] = message.html;
        #$('#iframe').contents()[0].close();
        #

        #$("#iframe").attr('src', '/stat/1')
        #
        #
        if $('#iframe') && $("#iframe")[0] && $("#iframe")[0].contentWindow && $("#iframe")[0].contentWindow.document
          frame = $("#iframe")[0].contentWindow.document;  

          frame.open()
          frame.write(message.html)
          frame.close()

