class TimeZone < ActiveRecord::Base
  attr_accessible :time_zone, :utc_offset_hours, :utc_offset_minutes, :human_confirmation_datetime
  has_one :user
  validates :time_zone, :presence => true
  validates :utc_offset_hours, :numericality => { :only_integer => true }
  validates :utc_offset_minutes, :numericality => { :only_integer => true }

  def to_label
    time_zone
  end
end
