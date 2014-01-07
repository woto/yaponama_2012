# encoding: utf-8
#
class ReceiveMailer < ActionMailer::Base

  helper :application

  def receive(message)

    message.from.each do |from|

      email = Email.find_or_initialize_by(value: from)
 
      user = nil

      if email.persisted?
        user = email.profile.somebody
      else
        user = User.new(SiteConfig.default_somebody_attributes)
        user.build_account

        profile = user.profiles.new

        message[:from].addrs.each do |addr|

          # Не знаю почему но это надо, чтобы правильно декодировалось имя
          addr.decoded

          if addr.display_name.present?
            name = profile.names.new(:name => addr.display_name)
            #name.creation_reason = 'email'
          end

          email = profile.emails.new(value: from)
          #email.creation_reason = 'email'
        end

        #user.save
      end

      @resource = user.talks.new(code_1: 'email')

      letter = Talkables::Letter.new(
        subject: message.subject,
        #source: message.body.to_s,
        letter: StringWithFileNameIO.new('email', message.raw_source),
        #letter_type: (message.mime_type || 'text/plain'),
        #size: message.body.to_s.length,
        #charset: message.charset
      )

      @resource.talkable = letter 
      @resource.creator = user

      #@talk = @user.talks.new(talk_params)

      user.save!
      #debugger

      #json = render_to_string(template: 'talks/_show.json.jbuilder', locals: { talk: talk })
      #$redis.publish('talk', json)
      #render :nothing => true

      #email_address.save

      #message.attachments.each do |attachment|
      #  file = StringIO.new(attachment.decoded)
      #  file.class.class_eval {attr_accessor :original_filename, :content_type}
      #  file.original_filename = attachment.filename
      #  file.content_type = attachment.mime_type
      #  attachment = Attachment.new(:attachment => file)
      #  email.attachments << attachment
      #  attachment.save
      #  email.save
      #end

      #email.user = user
      #email.save


      #
      #
      #puts Time.zone.now
      #
      #Ticket.receive_mail(message)

    end


    #if email.has_attachments?
    #  email.attachments.each do |attachment|
    #    page.attachments.create({
    #      :file => attachment,
    #      :description => email.subject
    #    })
    #  end
    #end
 
    message
  end

end
