class Bot < ActiveRecord::Base
  include BelongsToCreator

  validate :inet do |record|
    if inet.present?
      record.errors.add(:inet, nil) if (IPAddr.new(inet_before_type_cast) rescue nil).nil?
    end
  end

  def to_label
    "#{title} #{user_agent} #{inet} #{comment}"
  end

  after_save do

    removing_bot

    if inet.present?
      Somebody.where("remote_ip <<= ?", get_ip_mask(inet)[:w_cidr]).update_all(bot: true)
    end

    if user_agent.present?
      Somebody.where(Somebody.arel_table[:user_agent].matches("%#{user_agent}%")).update_all(bot: true)
    end

  end

  after_destroy do
    removing_bot
  end

  private

  def removing_bot

    if inet_was.present?
      Somebody.where("remote_ip <<= ?", get_ip_mask(inet_was)[:w_cidr]).update_all(bot: false)
    end

    if user_agent_was.present?
      Somebody.where(Somebody.arel_table[:user_agent].matches("%#{user_agent_was}%")).update_all(bot: false)
    end

  end

  def get_ip_mask(ipaddr)
    a = ipaddr.inspect.scan(/#<IPAddr: IPv4:(.*)\/(.*)>/)[0]
    b = a[1].to_i.to_s(2).count("1")
    return {
      w_mask: a[0].to_s + "/" + a[1].to_s,
      w_cidr: a[0].to_s + "/" + b.to_s
    }
  end


end
