Yaponama2012::Application.config.action_mailer.default_url_options = {
  :host => ::Rails.application.config_for('application/site')['host'],
  :port => ::Rails.application.config_for('application/site')['port'],
  :protocol => :http
}

Yaponama2012::Application.config.action_mailer.asset_host = "http://#{Rails.application.config_for('application/site')['host']}:#{Rails.application.config_for('application/site')['port']}"

ActionMailer::Base.default :from => ::Rails.application.config_for('application/mail')['from']

ActionMailer::Base.delivery_method = ::Rails.application.config_for('application/mail')['delivery_method'].to_sym

ActionMailer::Base.smtp_settings = ::Rails.application.config_for('application/mail')['smtp_settings']
