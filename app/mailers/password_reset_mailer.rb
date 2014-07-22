# encoding: utf-8
#
class PasswordResetMailer < ApplicationMailer

  def email(value, password_reset_token)
    @password_reset_token = password_reset_token
    @value = value
    mail to: value
  end

  def phone(value, password_reset_token)
    @password_reset_token = password_reset_token
    @value = value
    mail to: 'b049fb236f62a7f78166@avisosms.ru', subject: to_avisosms_format(value)
  end

end
