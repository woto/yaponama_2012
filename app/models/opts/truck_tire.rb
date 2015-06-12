class Opts::TruckTire < ActiveRecord::Base
  belongs_to :spare_info
  validates :spare_info, presence: true
end
