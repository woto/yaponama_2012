class Product < ActiveRecord::Base
  include PingCallback

  attr_accessible :catalog_number, :manufacturer, :short_name, :long_name
  validates :catalog_number, :manufacturer, :presence => true

  attr_accessible :buy_cost, :sell_cost
  validates :buy_cost, :numericality => { :greater_than => 0}
  validates :sell_cost, :numericality => { :greater_than => 0}

  validates :quantity_ordered, :numericality => { :greater_than_or_equal_to => 1 }

  belongs_to :user, :inverse_of => :products
  belongs_to :user, :inverse_of => :products_incart
  belongs_to :order, :inverse_of => :products_inorder
  belongs_to :order, :inverse_of => :products_ordered
  belongs_to :order, :inverse_of => :products

  belongs_to :supplier, :inverse_of => :products

  attr_accessible :notes, :notes_invisible, :max_days, :min_days, :probability, :quantity_available, :quantity_ordered, :status, :user_id, :order_id, :created_at, :updated_at

  attr_accessible :supplier_id

  before_save :set_relational_attributes

  def set_relational_attributes
    if self.order.present?
      self.user = self.order.user
    end
  end

end
