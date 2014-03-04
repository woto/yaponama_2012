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

end
