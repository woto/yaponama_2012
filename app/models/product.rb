class Product < ActiveRecord::Base
  include PingCallback
  belongs_to :user, :inverse_of => :products
  belongs_to :order
  attr_accessible :catalog_number, :manufacturer, :max_days, :min_days, :probability, :quantity_available, :quantity_ordered, :cost, :status, :user_id, :order_id

  before_save :set_relational_attributes

  def set_relational_attributes
    if self.order.present?
      self.user = self.order.user
    end
  end

end
