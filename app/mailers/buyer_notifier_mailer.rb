class BuyerNotifierMailer < ApplicationMailer

  def email(talk, email)
    @talk = talk
    mail to: email, subject: "Новое сообщение на сайте www.#{Rails.application.config_for('application/site')['host']}"
  end

  def phone(talk, phone)
    @talk = talk
    mail to: 'b049fb236f62a7f78166@avisosms.ru', subject: to_avisosms_format(phone)
  end
end
