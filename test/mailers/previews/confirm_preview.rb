class ConfirmPreview < ActionMailer::Preview

  def email
    ConfirmMailer.email(Email.order(:updated_at).last)
  end

  def phone
    ConfirmMailer.phone(Phone.order(:updated_at).last)
  end

end
