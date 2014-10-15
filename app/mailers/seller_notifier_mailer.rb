class SellerNotifierMailer < ApplicationMailer
  default to: Rails.application.config_for('application/mail')['from']

  def email(talk)
    @talk = talk
    mail subject: "Новое сообщение на сайте www.#{Rails.application.config_for('application/site')['host']} от #{@talk.somebody.to_label}"
  end
end
