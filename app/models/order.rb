class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  include PingCallback
  belongs_to :user, :inverse_of => :orders
  belongs_to :name, :inverse_of => :orders
  belongs_to :postal_address, :inverse_of => :orders

  has_many :products, :dependent => :destroy, :inverse_of => :order

  has_many :products_inorder, :dependent => :destroy, :inverse_of => :order, :conditions => {:products => {:status => :inorder}}, :class_name => "Product"
  attr_accessible :products_inorder_attributes
  accepts_nested_attributes_for :products_inorder, :allow_destroy => true

  has_many :products_ordered, :dependent => :destroy, :inverse_of => :order, :conditions => {:products => {:status => :ordered}}, :class_name => "Product"
  attr_accessible :products_ordered_attributes
  accepts_nested_attributes_for :products_ordered, :allow_destroy => true

  attr_accessible :name_id, :postal_address_id, :created_at, :updated_at
  has_many :documents, :as => :documentable, :class_name => "Transaction"

  def to_label
    "#{name_id} - #{postal_address_id} - #{user_id} - #{product_id} - #{created_at} - #{updated_at}"
  end

  before_save :update_money, :build_transaction

private

  def update_money
    self.money = products.reduce(0) {|summ, pi| summ + (pi.money * pi.quantity_ordered)}
  end

  def build_transaction
    documents.build(
      :left_account => user.account, 
      :left_real => true, 
      :left_money => - money,
      :right_account => user.account,
      :right_real => false,
      :right_money => money,
    )
  end

end
