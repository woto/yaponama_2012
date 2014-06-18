# encoding: utf-8
#
class SellerNotifierMailer < ApplicationMailer

  def email(talk, email)
    @talk = talk
    mail to: email, subject: 'Новое сообщение на сайте www.avtorif.ru'
  end
end
