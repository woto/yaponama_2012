class Bot < ActiveRecord::Base
  include BelongsToCreator
  #include ActiveRecord::ConnectionAdapters::PostgreSQLColumn::Cast

  validate :inet do |record|
    if inet.present?
      record.errors.add(:inet, nil) if (IPAddr.new(inet_before_type_cast) rescue nil).nil?
    end
  end

  def to_label
    "#{title} #{user_agent} #{to_inet(inet)} #{comment}"
  end

  after_save do

    removing_bot

    if inet.present?
      Somebody.where("remote_ip <<= ?", to_inet(inet)).update_all(bot: true)
    end

    if user_agent.present?
      Somebody.where(Somebody.arel_table[:user_agent].matches("%#{user_agent}%")).update_all(bot: true)
    end

  end

  after_destroy do
    removing_bot
  end

  def to_inet(value)
    "#{value.to_s}/#{value.instance_variable_get(:@mask_addr).to_s(2).count('1')}" if value
  end

  private

  def removing_bot

    if inet_was.present?
      Somebody.where("remote_ip <<= ?", to_inet(inet_was)).update_all(bot: false)
    end

    if user_agent_was.present?
      Somebody.where(Somebody.arel_table[:user_agent].matches("%#{user_agent_was}%")).update_all(bot: false)
    end

  end

end
