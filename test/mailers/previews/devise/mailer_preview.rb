class Devise::MailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.user.last
    token = user.send(:set_reset_password_token)
    Devise::Mailer.reset_password_instructions(user, token)
  end
end
