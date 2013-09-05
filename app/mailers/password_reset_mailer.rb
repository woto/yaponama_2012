class PasswordResetMailer < ApplicationMailer

  def email(value, password_reset_token)
    @password_reset_token = password_reset_token
    @value = value
    mail to: value
  end

  def phone(value, password_reset_token)
    @password_reset_token = password_reset_token
    @value = value
    mail to: SiteConfig.avisosms_email_address, subject: to_avisosms_format(value)
  end

end
