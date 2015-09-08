module Concerns::Models::Bot
  extend ActiveSupport::Concern
  included do
    scope :matched_records_by_remote_ip, -> (cidr) {where(arel_table[:current_sign_in_ip].contained_within_or_equals(cidr))}
    scope :matched_records_by_user_agent, -> (user_agent) {where(arel_table[:user_agent].matches(user_agent))}
  end
end
