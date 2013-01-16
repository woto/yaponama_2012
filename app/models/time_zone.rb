class TimeZone < ActiveRecord::Base
  has_one :user
  #validates :user, :presence => true

  validates :time_zone, :presence => true
  validates :utc_offset_hours, :numericality => { :only_integer => true }
  validates :utc_offset_minutes, :numericality => { :only_integer => true }

  def to_label
    time_zone
  end
end
