class UserMailer < ApplicationMailer

  def registration_letter_after_ordering(order, password)
    @order = order
    @password = password
    mail(to: order.user.email, bcc: bcc_recipients(order), subject: "Авториф. Заказ №#{order.to_label} успешно оформлен")
  end

  def letter_after_ordering(order)
    @order = order
    mail(to: order.user.email, bcc: bcc_recipients(order), subject: "Авториф. Заказ №#{order.to_label} успешно оформлен")
  end

  private

  def bcc_recipients(order)
    bcc = []
    bcc << Rails.configuration.common['mail']
    bcc << order.deliveries_place.email if order.deliveries_place
  end

end
