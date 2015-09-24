class Devise::MailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.limit(1).order(:reset_password_sent_at => :desc).where.not(:reset_password_sent_at => nil).first
    token = user.send(:set_reset_password_token)
    Devise::Mailer.reset_password_instructions(user, token)
  end
end
