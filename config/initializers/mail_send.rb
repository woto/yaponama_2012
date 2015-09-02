Yaponama2012::Application.config.action_mailer.default_url_options = {
  :host => ::Rails.configuration.site['host'],
  :port => ::Rails.configuration.site['port'],
  :protocol => :http
}

Yaponama2012::Application.config.action_mailer.asset_host = "http://#{Rails.configuration.site['host']}:#{Rails.configuration.site['port']}"

ActionMailer::Base.default :from => ::Rails.configuration.mail['from']

ActionMailer::Base.delivery_method = ::Rails.configuration.mail['delivery_method'].to_sym

ActionMailer::Base.smtp_settings = ::Rails.configuration.mail['smtp_settings']
