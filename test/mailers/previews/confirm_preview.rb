class ConfirmPreview < ActionMailer::Preview

  def email
    ConfirmMailer.email(Email.last)
  end

  def phone
    ConfirmMailer.phone(Phone.last)
  end

end
