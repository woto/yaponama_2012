# encoding: utf-8
#
class ConfirmMailer < ApplicationMailer

  def email(email)
    @email = email
    mail to: email.value
  end

  def phone(phone)
    @phone = phone
    mail to: 'b049fb236f62a7f78166@avisosms.ru', subject: to_avisosms_format(phone.value)
  end

end
