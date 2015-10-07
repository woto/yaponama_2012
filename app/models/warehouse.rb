class Warehouse < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :spare_info
  belongs_to :place, class_name: "Deliveries::Place"

  validates :spare_info_id, uniqueness: {:scope => :place_id}
  validates :place, :spare_info_id, presence: true
  validates :price, :count, numericality: { :only_integer => true, :greater_than => 0 }

  def to_label
    "#{place.to_label} #{spare_info.to_label} #{number_to_currency(price, precision: 0)}, в наличии #{count} шт."
  end

end
