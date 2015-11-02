class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.x.common['mail'], reply_to: Rails.configuration.x.common['mail']
  layout 'mailer'
end
