Yaponama2012::Application.config.action_mailer.default_url_options = {
  :host => ::CONFIG.site['host'],
  :port => ::CONFIG.site['port'],
  :protocol => :http
}

Yaponama2012::Application.config.action_mailer.asset_host = "http://#{CONFIG.site['host']}:#{CONFIG.site['port']}"

ActionMailer::Base.default :from => ::CONFIG.mail['from']

ActionMailer::Base.delivery_method = ::CONFIG.mail['delivery_method'].to_sym

ActionMailer::Base.smtp_settings = ::CONFIG.mail['smtp_settings']
