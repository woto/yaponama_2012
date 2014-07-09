# encoding: utf-8
#
class ConfirmMailer < ApplicationMailer

  def email(email)
    @email = email
    mail to: email.value
  end

  def phone(phone)
    @phone = phone
    mail to: 'avisosms@fake.ru', subject: to_avisosms_format(phone.value)
  end

end
