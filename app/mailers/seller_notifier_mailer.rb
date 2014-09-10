class SellerNotifierMailer < ApplicationMailer
  default to: CONFIG.mail['from']

  def email(talk)
    @talk = talk
    mail subject: "Новое сообщение на сайте www.#{CONFIG.site['host']} от #{@talk.somebody.to_label}"
  end
end
