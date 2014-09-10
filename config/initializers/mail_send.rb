Yaponama2012::Application.config.action_mailer.default_url_options = {
  :host => ::CONFIG.site['host'],
  :port => ::CONFIG.site['port'],
  :protocol => :http
}

Yaponama2012::Application.config.action_mailer.asset_host = "http://#{CONFIG.site['host']}:#{CONFIG.site['port']}"

ActionMailer::Base.default :from => ::CONFIG.mail['from']

ActionMailer::Base.delivery_method = ::CONFIG.mail['delivery_method'].to_sym

ActionMailer::Base.smtp_settings = {
  address:              ::CONFIG.mail['smtp_address'],
  port:                 ::CONFIG.mail['smtp_port'],
  user_name:            ::CONFIG.mail['smtp_user_name'],
  password:             ::CONFIG.mail['smtp_password'],
  authentication:       ::CONFIG.mail['smtp_authentication'],
  enable_starttls_auto: ::CONFIG.mail['smtp_enable_starttls_auto']
}
