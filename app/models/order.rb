class Order < ActiveRecord::Base

  def active?
    status == 'active'
  end

  include PingCallback
  attr_accessible :delivery_id, :delivery_cost
  belongs_to :delivery, :inverse_of => :orders
  belongs_to :user, :inverse_of => :orders
  belongs_to :name, :inverse_of => :orders
  belongs_to :postal_address, :inverse_of => :orders

  has_many :products, :dependent => :destroy, :inverse_of => :order
  attr_accessible :products_attributes
  accepts_nested_attributes_for :products, :allow_destroy => true

  has_many :products_inorder, :dependent => :destroy, :inverse_of => :order, :conditions => {:products => {:status => :inorder}}, :class_name => "Product"
  attr_accessible :products_inorder_attributes
  accepts_nested_attributes_for :products_inorder, :allow_destroy => true

  has_many :products_ordered, :dependent => :destroy, :inverse_of => :order, :conditions => {:products => {:status => :ordered}}, :class_name => "Product"
  attr_accessible :products_ordered_attributes
  accepts_nested_attributes_for :products_ordered, :allow_destroy => true


  has_many :products_inwork, :dependent => :destroy, :inverse_of => :order, :conditions => {:products => {:status => :inwork}}, :class_name => "Product"
  attr_accessible :products_inwork_attributes
  accepts_nested_attributes_for :products_inwork, :allow_destroy => true

  attr_accessible :name_id, :postal_address_id, :created_at, :updated_at, :status
  has_many :documents, :as => :documentable, :class_name => "Transaction"

  def to_label
    "#{name_id} - #{postal_address_id} - #{user_id} - #{created_at} - #{updated_at}"
  end

  validate :order_cost, :numericality => true

  before_save :update_order_cost
  #before_create :build_transaction

private

  def update_order_cost
    self.order_cost = products.reduce(0) {|summ, pi| summ + (pi.sell_cost * pi.quantity_ordered)}
  end

  #def build_transaction
  #  documents.build(
  #    :left_account => user.account,
  #    :left_real => false, 
  #    :left_money => user.account.money_locked + self.money,
  #  )
  #end

end
