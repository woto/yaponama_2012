Yaponama2012::Application.config.action_mailer.default_url_options = { :host => ::SiteConfig.site_full_address }
ActionMailer::Base.default :from => ::SiteConfig.from_email_address
