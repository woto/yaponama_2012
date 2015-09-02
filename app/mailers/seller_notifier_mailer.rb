class SellerNotifierMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  default to: Rails.configuration.mail['from']

  def sitename
    "www.#{Rails.configuration.site['host']}"
  end

  def incart product
    @product = product
    mail subject: "#{@product.creator.to_label} поместил товар #{@product.to_label} в корзину, #{sitename}"
  end

  def payment payment
    @payment = payment
    mail subject: "#{@payment.somebody.to_label} внес оплату на сумму #{number_to_currency(@payment.amount)}, #{sitename}"
  end

  def callback callback
    @callback = callback
    mail subject: "#{@callback.name} заказал обратный звонок на #{@callback.phone}, #{sitename}"
  end
end
