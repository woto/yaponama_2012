class Order < ActiveRecord::Base
  include PingCallback
  attr_accessible :phone_id, :notes, :notes_invisible
  attr_accessible :delivery_id, :delivery_cost
  belongs_to :delivery
  belongs_to :name
  belongs_to :phone
  belongs_to :postal_address

  belongs_to :user, :validate => true
  validates :user, :presence => true

  validates_associated :delivery
  validates_associated :postal_address
  validates_associated :name
  validates_associated :phone

  has_many :products, :dependent => :destroy
  attr_accessible :products_attributes
  accepts_nested_attributes_for :products, :allow_destroy => true

  has_many :products_inorder, :dependent => :destroy,
    :conditions => {:products => {:status => 'inorder'}}, :class_name => "Product",
    :after_add => Proc.new{|p, d| p.status = 'inorder'}
  attr_accessible :products_inorder_attributes
  accepts_nested_attributes_for :products_inorder, :allow_destroy => true

  has_many :products_ordered, :dependent => :destroy,
    :conditions => {:products => {:status => 'ordered'}}, :class_name => "Product",
    :after_add => Proc.new{|p, d| p.status = 'ordered'}
  attr_accessible :products_ordered_attributes
  accepts_nested_attributes_for :products_ordered, :allow_destroy => true

  has_many :products_inwork, :dependent => :destroy,
    :conditions => {:products => {:status => 'inwork'}}, :class_name => "Product",
    :after_add => Proc.new{|p, d| p.status = 'inwork'}
  attr_accessible :products_inwork_attributes
  accepts_nested_attributes_for :products_inwork, :allow_destroy => true

  attr_accessible :name_id, :postal_address_id, :created_at, :updated_at, :status
  has_many :documents, :as => :documentable, :class_name => "Transaction"

  def to_label
    "#{id}"
  end

  validate :order_cost, :numericality => true

  before_save :update_order_cost
  #before_create :build_transaction


  def active?
    raise 'method active? deprecated'
    status == 'active'
  end

  validate :multistep_order

  def multistep_order
    unless delivery
      errors.add(:delivery, "Delivery required for order")
    else
      if delivery.postal_address_required && postal_address.blank?
        errors.add(:postal_address, "Postal address required for this delivery method")
      end
      if delivery.name_required && name.blank?
        errors.add(:name, "Name required for this delivery method")
      end
      if delivery.phone_required && phone.blank?
        errors.add(:phone, "Phone required for this delivery method")
      end
      if delivery.delivery_cost_required && delivery_cost.blank?
        errors.add(:delivery_cost, "Delivery cost required for this delivery method")
      end
      unless products.present? || products_inorder.present? || products_ordered.present?
        errors.add(:products, 'There is no products in this order')
      end
    end
  end

  before_validation :set_relational_attributes

  def set_relational_attributes
    if products_inorder
      products_inorder.each do |product|
        product.user = self.user
      end
    end

    #if products_ordered
    #  products_inorder.each do |product|
    #    product.user = self.user
    #  end
    #end

  end

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
  #

end
