class PasswordResetPreview < ActionMailer::Preview

  def email
    PasswordResetMailer.email(Email.order(:updated_at).last.value, Email.order(:updated_at).last.somebody.password_reset_token)
  end

  def phone
    PasswordResetMailer.phone(Phone.order(:updated_at).last.value, Phone.order(:updated_at).last.somebody.password_reset_token)
  end

end
