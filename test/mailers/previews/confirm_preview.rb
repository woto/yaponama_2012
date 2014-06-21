class ConfirmPreview < ActionMailer::Preview

  def email
    ConfirmMailer.email(Email.where.not(confirmation_token: nil).first)
  end

  def phone
    phone = Phone.where.not(confirmation_token: nil).first
    raise 'Нет телефона, у которого confirmation_token есть nil' unless phone
    ConfirmMailer.phone(phone)
  end

end
