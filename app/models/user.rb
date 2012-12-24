#encoding: utf-8

class User < ActiveRecord::Base
  include BelongsToCreator
  include PingCallback

  has_many :uploads

  def self.current_user=(current_user)
    Thread.current[:current_user] = current_user
  end
  
  def self.current_user
    Thread.current[:current_user]
  end

  # override has_secure_password to customize validation until Rails 4. Railscasts 393
  # has_secure_password(validation: false)
  require 'bcrypt'
  attr_reader :password
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation
  # until this

  validates :password_digest, :presence => true, unless: Proc.new {self.role == "guest"}

  validates :password, :confirmation => true, :length => { :minimum => 6 }, :allow_nil => true, :allow_blank => true #, unless: Proc.new {["admin", "manager"].include? User.current_user.role}

  attr_accessible :password, :as => [:admin, :manager, :user, :guest]
  attr_accessible :password_confirmation, :as => [:admin, :manager, :user, :guest]

  # Railscasts 274
  #
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  #
  # /Railscasts 274
  
  validate :role do
    if (["admin", "manager", "user"].include? role_was) && role == "guest"
      errors.add(:role, 'Невозможно изменить роль пользователя с имеющейся на "Гость"')
      return false
    end
  end

  attr_accessible :notes, :notes_invisible, :as => [:admin, :manager, :user, :guest]
  attr_accessible :created_at, :updated_at, :as => [:admin, :manager, :user, :guest]

  attr_accessible :cars_attributes, :as => [:admin, :manager, :user, :guest]
  has_many :cars, :dependent => :destroy
  accepts_nested_attributes_for :cars, :allow_destroy => true 

  attr_accessible :requests_attributes
  has_many :requests, :dependent => :destroy
  accepts_nested_attributes_for :requests, :allow_destroy => true 

  attr_accessible :root_requests_without_car_attributes, :as => [:admin, :manager, :user, :guest]
  has_many :root_requests_without_car, :dependent => :destroy,
    :conditions => ["request_id IS NULL AND car_id IS NULL"], :class_name => "Request"
  accepts_nested_attributes_for :root_requests_without_car, :allow_destroy => true

  def products_inwork
    products.where("STRPOS(?, status) > 0", "ordered,pre_supplier,post_supplier,stock").sum("sell_cost * quantity_ordered").to_d
  end

  attr_accessible :products_attributes, :as => [:admin, :manager, :user, :guest]
  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :allow_destroy => true

  attr_accessible :root_products_attributes, :as => [:admin, :manager, :user, :guest]
  has_many :root_products, :dependent => :destroy,
    :conditions => ["product_id IS NULL"], :class_name => "Product"
  accepts_nested_attributes_for :root_products, :allow_destroy => true
  
  attr_accessible :phones_attributes, :email_addresses_attributes, :postal_addresses_attributes, :names_attributes, :human_confirmation_datetime, :orders_attributes, :as => [:admin, :manager, :user, :guest]



  has_many :email_addresses, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :postal_addresses, :dependent => :destroy
  has_many :names, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  accepts_nested_attributes_for :phones, :postal_addresses, :email_addresses, :names, :orders, :allow_destroy => true

  attr_accessible :time_zone_id, :as => [:admin, :manager, :user, :guest]
  belongs_to :time_zone#, :validate => true
  #validates :time_zone, :presence => true

  has_one :ping, :dependent => :destroy
  # TODO позже разобраться (обнаружил как неиспользуемую ассоциацию)
  #has_many :documents, :as => :documentable, :class_name => "Transaction"

  attr_accessible :prepayment_percent, :discount, :order_rule, :role, :as => [:admin, :manager, :user, :guest]
  validates :discount, :prepayment_percent, :numericality => true
  validates :order_rule, :inclusion => { :in => Rails.configuration.user_order_rule.keys }
  validates :role, :inclusion => Rails.configuration.user_roles.keys

  # Financial
  attr_accessible :account_attributes, :as => [:admin, :manager, :user, :guest]
  has_one :account, :as => :accountable, :dependent => :destroy
  accepts_nested_attributes_for :account
  validates :account, :presence => true


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!

    namespace = nil
    if ["admin", "manager"].include? self.role
      namespace = "admin"
    end

    UserMailer.password_reset(namespace, self).deliver
  end


  def to_label
    "#{names.collect(&:name).join(', ')}"
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

  before_validation :set_relational_attributes

  def set_relational_attributes
    if names
      names.each do |name|
        name.user = self
      end
    end

    if phones
      phones.each do |phone|
        phone.user = self
      end
    end

    if email_addresses
      email_addresses.each do |email_address|
        email_address.user = self
      end
    end

    if postal_addresses
      postal_addresses.each do |postal_address|
        postal_address.user = self
      end
    end

    if cars
      cars.each do |car|
        car.user = self
      end
    end

    if requests
      requests.each do |request|
        request.user = self
      end
    end

    if root_requests_without_car
      root_requests_without_car.each do |request|
        request.user = self
      end
    end

    if root_products
      root_products.each do |product|
        product.user = self
      end
    end

    if products
      products.each do |product|
        product.user = self
      end
    end

    if orders
      orders.each do |order|
        order.user = self
      end
    end

  end

end
