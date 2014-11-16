class PasswordResetPreview < ActionMailer::Preview

  def email
    PasswordResetMailer.email(Email.last.value, Email.last.somebody.password_reset_token)
  end

  def phone
    PasswordResetMailer.phone(Phone.last.value, Phone.last.somebody.password_reset_token)
  end

end
