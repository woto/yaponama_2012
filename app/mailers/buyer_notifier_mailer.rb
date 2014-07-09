# encoding: utf-8
#
class BuyerNotifierMailer < ApplicationMailer

  def email(talk, email)
    @talk = talk
    mail to: email, subject: 'Новое сообщение на сайте www.avtorif.ru'
  end

  def phone(talk, phone)
    @talk = talk
    mail to: 'avisosms@fake.ru', subject: to_avisosms_format(phone)
  end
end
