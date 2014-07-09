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
    mail to: 'avisosms@fake.ru', subject: to_avisosms_format(value)
  end

end
