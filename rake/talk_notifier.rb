class TalkNotifier
    def self.talk_notifier
      Talk.where(notified: false, read: false).where("created_at <= ?", 10.seconds.ago).each do |talk|
        talk.update_column(:notified, true)
        if talk.creator.buyer?
          SellerNotifierMailer.email(talk).deliver
        elsif talk.creator.seller?
          talk.somebody.profile.emails.each{|email| BuyerNotifierMailer.email(talk, email.value).deliver}
          talk.somebody.profile.phones.each{|phone| BuyerNotifierMailer.phone(talk, phone.value).deliver}
        end
      end
    end
end