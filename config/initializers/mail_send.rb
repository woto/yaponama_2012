Yaponama2012::Application.config.action_mailer.default_url_options = { :host => ::SiteConfig.site_full_address }
ActionMailer::Base.default :from => ::SiteConfig.from_email_address

ActionMailer::Base.delivery_method = ::SiteConfig.mail_delivery_method.to_sym

ActionMailer::Base.smtp_settings = {
  address:              ::SiteConfig.smtp_address,
  port:                 ::SiteConfig.smtp_port,
  user_name:            ::SiteConfig.smtp_user_name,
  password:             ::SiteConfig.smtp_password,
  authentication:       ::SiteConfig.smtp_authentication,
  enable_starttls_auto: ::SiteConfig.smtp_enable_starttls_auto  
}
