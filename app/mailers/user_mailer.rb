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


  def receive(message)
      message.from.each do |from|

        email_address = EmailAddress.find_or_initialize_by_email_address(from)
   
        user = nil

        if email_address.user.blank?
          user = email_address.build_user(SiteConfig.default_user_attributes)
          user.build_account
          user.creation_reason = :email
          user.save
        else
          user = email_address.user
        end

        message[:from].addrs.each do |addr|
          addr.decoded
          name = Name.new(:name => addr.display_name)
          name.creation_reason = :email
          email_address.user.names << name


          email_address.save

          message.subject.to_s

          email = Email.new(
            :email_address => email_address,
            :from => message.from.to_s, 
            :to => message.to.to_s,
            :subject => message.subject.to_s,
            :body => message.body.to_s,
            :cc_addrs => message.cc_addrs.to_s,
            :bcc_addrs => message.bcc_addrs.to_s,
            :bcc => message.bcc.to_s,
            :cc => message.cc.to_s,
            :resent_bcc => message.resent_bcc.to_s,
            :resent_cc => message.resent_cc.to_s,
            :is_multipart => message.multipart?,
            :parts_length => message.parts.length,
            :date => message.date.to_s,
            :message_id => message.message_id.to_s,
            :name => message[:from].decoded.to_s,
            :from_addrs => message.from_addrs.to_s, 
            :content_types => message.parts.map {|p| p.content_type}.join(', ').to_s,
            :classes => message.parts.map {|p| p.class}.join(', ').to_s,
            #:return_path => message.return_path, 
            :return_path => message[:from].decoded.to_s,
            :in_reply_to => message.in_reply_to.to_s,
            :to_addrs => message.to_addrs.to_s, 
            :html_part => message.html_part ? message.html_part.body.to_s : nil,
            :text_part => (message.multipart? ? (message.text_part ? message.text_part.body.to_s : nil) : message.body.to_s)
          )

          email_address.save

          message.attachments.each do |attachment|
            file = StringIO.new(attachment.decoded)
            file.class.class_eval {attr_accessor :original_filename, :content_type}
            file.original_filename = attachment.filename
            file.content_type = attachment.mime_type
            attachment = Attachment.new(:attachment => file)
            email.attachments << attachment
            attachment.save
            email.save
          end

          email.user = user
          email.save


          #debugger
          #EmailMailer.welcome_email({:name => addr.display_name, :email => addr.address, :login => "fake"}).deliver
          #
          #
          #puts Time.zone.now
          #
          #Ticket.receive_mail(message)


        end

      end

    #if email.has_attachments?
    #  email.attachments.each do |attachment|
    #    page.attachments.create({
    #      :file => attachment,
    #      :description => email.subject
    #    })
    #  end
    #end
  end

end
