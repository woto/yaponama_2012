class User < ActiveRecord::Base

  attr_accessible :notes, :notes_invisible
  attr_accessible :created_at, :updated_at

  after_initialize  do |user|
    unless user.account
      user.account = Account.new
    end
  end

  has_many :products, :dependent => :destroy, :inverse_of => :user

  has_many :products_incart, :dependent => :destroy, :inverse_of => :user, :conditions => {:status => :incart}, :class_name => "Product"
  attr_accessible :products_incart_attributes
  accepts_nested_attributes_for :products_incart, :allow_destroy => true

  include PingCallback
  attr_accessible :name, :phones_attributes, :email_addresses_attributes, :postal_addresses_attributes, :cars_attributes, :names_attributes, :requests_attributes, :time_zone_id, :human_confirmation_datetime, :orders_attributes, :money_available, :money_locked, :discount, :prepayment_percent
  has_many :email_addresses, :dependent => :destroy, :inverse_of => :user
  has_many :phones, :dependent => :destroy, :inverse_of => :user
  has_many :postal_addresses, :dependent => :destroy, :inverse_of => :user
  has_many :cars, :dependent => :destroy, :inverse_of => :user
  has_many :names, :dependent => :destroy, :inverse_of => :user
  has_many :requests, :dependent => :destroy, :inverse_of => :user
  has_many :orders, :dependent => :destroy, :inverse_of => :user
  accepts_nested_attributes_for :phones, :postal_addresses, :email_addresses, :cars, :names, :requests, :orders, :allow_destroy => true
  belongs_to :time_zone, :validate => true
  has_one :ping, :dependent => :destroy, :inverse_of => :user
  has_many :documents, :as => :documentable, :class_name => "Transaction"

  validates :prepayment_percent, :numericality => true
  validates :discount, :numericality => true

  attr_accessible :order_rule
  validates :order_rule, :inclusion => { :in => Rails.configuration.user_order_rule.keys }

  # Financial
  attr_accessible :account_attributes
  has_one :account, :as => :accountable
  accepts_nested_attributes_for :account

  def to_label
    "#{id} - #{names.collect{|name| name.name}.join(', ')}"
  end

  def check_orders
    raise '1'
    # TODO CHECK
    
    if order_rule.to_sym == :none
      return
    elsif order_rule.to_sym == :all 
      inorder_orders = orders.where(:status => :inorder)
      unless (account.debit + inorder_orders.inject(0){|summ, order| summ += order.order_cost}) * prepayment_percent / 100.00 <= account.credit
        return
      end

      inorder_orders.each do |order|
        if (account.debit + order.order_cost) * prepayment_percent / 100.00 <= account.credit
          order.status = :ordered
          order.products.each do |product|
            product.update_attributes(:status => :ordered)
          end
          account.debit += order.order_cost
          order.save
          account.save
        end
      end

    end

  end
end
