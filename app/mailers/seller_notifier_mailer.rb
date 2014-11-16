class SellerNotifierMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  default to: Rails.application.config_for('application/mail')['from']

  def email(talk)
    @talk = talk
    mail subject: "www.#{Rails.application.config_for('application/site')['host']}, новое сообщение от #{@talk.somebody.to_label}"
  end

  def incart product
    @product = product
    mail subject: "www.#{Rails.application.config_for('application/site')['host']}, пользователь #{@product.creator.to_label} поместил товар #{@product.to_label} в корзину"
  end

  def payment payment
    @payment = payment
    mail subject: "www.#{Rails.application.config_for('application/site')['host']}, поступила оплата от #{@payment.somebody.to_label} на сумму #{number_to_currency(@payment.amount)}"
  end
end
