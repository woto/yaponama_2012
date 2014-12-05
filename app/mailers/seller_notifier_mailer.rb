class SellerNotifierMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  default to: Rails.application.config_for('application/mail')['from']

  def email(talk)
    @talk = talk
    mail subject: "#{@talk.somebody.to_label} прислал сообщение, www.#{Rails.application.config_for('application/site')['host']}"
  end

  def incart product
    @product = product
    mail subject: "#{@product.creator.to_label} поместил товар #{@product.to_label} в корзину, www.#{Rails.application.config_for('application/site')['host']}"
  end

  def payment payment
    @payment = payment
    mail subject: "#{@payment.somebody.to_label} внес оплату на сумму #{number_to_currency(@payment.amount)}, www.#{Rails.application.config_for('application/site')['host']}"
  end
end
