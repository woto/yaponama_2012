# encoding: utf-8
#
class Deliveries::Variant < ActiveRecord::Base
  include HiddenRecreate
  belongs_to :place

  #has_one :option

  validates :name, presence: true
  validates :sequence, presence: true, numericality: true
  validates :delivery_cost, presence: true, numericality: true

  def to_label
    "#{name} - #{ActionController::Base.helpers.number_to_currency(delivery_cost)}"
  end

end
