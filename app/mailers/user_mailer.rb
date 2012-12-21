class UserMailer < ActionMailer::Base

  default :from => "boss@yaponama.ru"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  #def password_reset
  #  @greeting = "Hi"
  #
  #  mail to: "to@example.org"
  #end


  def password_reset(namespace, user)
    @user = user
    user.email_addresses.each do |email_address|
      mail :to => email_address.email_address, :subject => "Password Reset", :namespace => namespace
    end
  end


  def receive(email)
    page = Page.find_by_address(email.to.first)
    page.emails.create(
      :subject => email.subject,
      :body => email.body
    )
 
    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({
          :file => attachment,
          :description => email.subject
        })
      end
    end
  end

end
