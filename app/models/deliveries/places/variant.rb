class Deliveries::Places::Variant < ActiveRecord::Base
  belongs_to :place

  def to_label
    "#{name} - #{ActionController::Base.helpers.number_to_currency(delivery_cost)}"

  end
end
