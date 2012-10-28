class Product < ActiveRecord::Base
  include PingCallback

  attr_accessible :catalog_number, :manufacturer
  validates :catalog_number, :manufacturer, :presence => true
  validates :money, :presence => true
  validates :quantity_ordered, :presence => true

  belongs_to :user, :inverse_of => :products
  belongs_to :user, :inverse_of => :products_incart
  belongs_to :order, :inverse_of => :products_inorder
  belongs_to :order, :inverse_of => :products_ordered
  belongs_to :order, :inverse_of => :products


  attr_accessible :notes, :invisible, :max_days, :min_days, :probability, :quantity_available, :quantity_ordered, :money, :status, :user_id, :order_id, :created_at, :updated_at

  before_save :set_relational_attributes

  def set_relational_attributes
    if self.order.present?
      self.user = self.order.user
    end
  end

end
