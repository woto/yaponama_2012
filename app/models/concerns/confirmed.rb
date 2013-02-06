module Confirmed
  extend ActiveSupport::Concern

  included do
    scope :confirmed, -> { 
      where(( arel_table[:confirmed_by_robot].eq(true) ).or( arel_table[:confirmed_by_human].eq(true) ))
    }
  end

  def confirmed?
    confirmed_by_robot || confirmed_by_human
  end

  def confirmed_changed?
    confirmed_by_robot_changed? || confirmed_by_human_changed?
  end

  def reset_confirmed
    self.confirmed_by_robot = false
    self.confirmed_by_human = false
  end

end
