class CsrfProtection
  #def outgoing(message, callback)
  #  Rails.logger.info "\033[0;34mOUT\033[0;37m"
  #  message['ext'] = '@@@@@@@@@@@@@@@'
  #  Rails.logger.info message
  #  callback.call(message)
  #end

  def incoming(message, request, callback)
    Rails.logger.info "\033[0;34mIN\033[0;37m"

    if message['channel'] == '/meta/subscribe'
      user = User.find_by(auth_token: request.cookies['auth_token'])
      user.update!(online: true)
      # Если собственный канал или администратор/менеджер
      # message['error'] = "Youre can't subscribe on this channel"
    end

    #if message['channel']['/meta/disconnect']
    #end
    #env['faye.client'].publish('/messages', '/messages')


    ##puts request.session
    ##puts request.cookies
    #
    Rails.logger.info message
    callback.call(message)
  end
end

Rails.application.config.middleware.insert_after ActionDispatch::Session::CookieStore,
  Faye::RackAdapter,
  :extensions => [CsrfProtection.new],
  :mount      => '/faye',
  :timeout    => 25,
  :engine  => {
    :type  => Faye::Redis,
    :host  => SiteConfig.redis_address,
    :port  => SiteConfig.redis_port
  }
