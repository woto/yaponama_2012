class SellerNotifierMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  default to: Rails.application.config_for('application/mail')['from']

  def email(talk)
    @talk = talk
    mail subject: "Новое сообщение на сайте www.#{Rails.application.config_for('application/site')['host']} от #{@talk.somebody.to_label}"
  end

  def payment payment
    @payment = payment
    mail subject: "Поступила оплата на сайте www.#{Rails.application.config_for('application/site')['host']} от #{@payment.somebody.to_label} на сумму #{number_to_currency(@payment.amount)}"
  end
end
