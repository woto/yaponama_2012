module Confirmed
  extend ActiveSupport::Concern

  included do
    scope :confirmed, -> { 
      where(( arel_table[:confirmed_by_user].eq(true) ).or( arel_table[:confirmed_by_manager].eq(true) ))
    }
  end

  def confirmed?
    confirmed_by_user || confirmed_by_manager
  end

  def confirmed_changed?
    confirmed_by_user_changed? || confirmed_by_manager_changed?
  end

  def reset_confirmed
    self.confirmed_by_user = false
    self.confirmed_by_manager = false
    self.confirmation_token = SecureRandom.hex[0...4]
  end

end
