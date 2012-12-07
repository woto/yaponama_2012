class Order < ActiveRecord::Base
  include PingCallback

  #before_create :build_transaction

  attr_accessible :phone_id, :notes, :notes_invisible
  attr_accessible :delivery_id, :delivery_cost
  belongs_to :delivery
  belongs_to :name
  belongs_to :phone
  belongs_to :postal_address

  belongs_to :metro
  attr_accessible :metro_id
  validates_associated :metro

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
    :before_add => :before_add_inorder
  
  def before_add_inorder p
    p.status = 'inorder'
    # TODO check
    #p.status_will_change!
  end

  attr_accessible :products_inorder_attributes
  accepts_nested_attributes_for :products_inorder, :allow_destroy => true

  has_many :products_ordered, :dependent => :destroy,
    :conditions => {:products => {:status => 'ordered'}}, :class_name => "Product",
    :before_add => :before_add_ordered

  def before_add_ordered
    p.status = 'ordered'
    # TODO check
    #p.status_will_change!
  end

  attr_accessible :products_ordered_attributes
  accepts_nested_attributes_for :products_ordered, :allow_destroy => true

  #has_many :products_inwork, :dependent => :destroy,
  #  :conditions => {:products => {:status => 'inwork'}}, :class_name => "Product",
  #  # TODO если буду раскомментировать блок, то переделать как вверху
  #  :after_add => Proc.new{|i, p| p.status = 'inwork'; d.status_will_change!}
  #attr_accessible :products_inwork_attributes
  #accepts_nested_attributes_for :products_inwork, :allow_destroy => true

  attr_accessible :name_id, :postal_address_id, :created_at, :updated_at, :status
  has_many :documents, :as => :documentable, :class_name => "Transaction"

  def to_label
    "#{id}"
  end

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
      if delivery.metro_required && metro.blank?
        errors.add(:metro, "Metro required for this delivery method")
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

    if products
      products.each do |product|
        product.user = self.user
      end
    end

    if products_inorder
      products_inorder.each do |product|
        product.user = self.user
      end
    end

    if products_ordered
      products_ordered.each do |product|
        product.user = self.user
      end
    end

  end

  def inorder_order_cost
    products_inorder.reduce(0) {|summ, pi| summ + (pi.sell_cost * pi.quantity_ordered)}
  end
  
  def ordered_order_cost
    products_ordered.reduce(0) {|summ, pi| summ + (pi.sell_cost * pi.quantity_ordered)}
  end


  
private

  #def build_transaction
  #  documents.build(
  #    :left_account => user.account,
  #    :left_real => false, 
  #    :left_money => user.account.money_locked + self.money,
  #  )
  #end
  #

end
