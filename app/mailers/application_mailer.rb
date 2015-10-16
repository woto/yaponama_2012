class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.common['mail'], reply_to: Rails.configuration.common['mail']
  layout 'mailer'
end
