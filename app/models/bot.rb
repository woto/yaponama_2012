class Bot < ActiveRecord::Base

  scope :matched_records_by_remote_ip, -> (remote_ip) {where(arel_table[:inet].eq(nil).or(arel_table[:inet].contains_or_equals(remote_ip)))}
  scope :matched_records_by_user_agent, -> (user_agent) {where(arel_table[:user_agent].eq(nil).or(Arel::Nodes::Matches.new(Arel::Nodes.build_quoted(user_agent.to_s), arel_table[:user_agent])))}

  validates :inet, presence: true, if: -> {user_agent.blank?}
  validates :user_agent, presence: true, if: -> {inet.blank?}

  validate :inet do |record|
    if inet_before_type_cast.present?
      record.errors.add(:inet, 'not valid ip address') if ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Cidr.new.cast_value(inet_before_type_cast).nil?
    end
  end

  before_validation do
    self.user_agent = nil if user_agent.blank?
    self.inet = nil if inet.blank?
  end

  def to_label
    title || "#{user_agent} #{cidr}"
  end

  def cidr
    ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Cidr.new.type_cast_for_database inet
  end

end
