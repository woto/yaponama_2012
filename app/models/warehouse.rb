class Warehouse < ActiveRecord::Base
  belongs_to :spare_info
  belongs_to :place, class_name: "Deliveries::Place"

  validates :spare_info_id, uniqueness: {:scope => :place_id}
  validates :place, :spare_info_id, presence: true
  validates :price, :count, numericality: { :only_integer => true, :greater_than => 0 }
end
