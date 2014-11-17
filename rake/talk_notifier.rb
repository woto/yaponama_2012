class TalkNotifier
    def self.talk_notifier
      Talk.where(notified: false, read: false).where("created_at <= ?", 10.seconds.ago).each do |talk|
        talk.update_column(:notified, true)
        if talk.creator.buyer?
          SellerNotifierMailer.email(talk).deliver_later
        # Если продавец написал покупателю и покупатель вышел
        # и у него отсутствует профиль talk.somebody.profile
        elsif talk.creator.seller? && talk.somebody.profile
          talk.somebody.profile.emails.each{|email| BuyerNotifierMailer.email(talk, email.value).deliver_later}
          talk.somebody.profile.phones.each{|phone| BuyerNotifierMailer.phone(talk, phone.value).deliver_later}
        end
      end
    end
end
