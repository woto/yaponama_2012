#encoding: utf-8

class User < ActiveRecord::Base

  # TODO Удалить две следующие строчки
  has_many :root_products, -> { where("product_id IS NULL") }, :class_name => "Product", :dependent => :destroy
  accepts_nested_attributes_for :root_products, :allow_destroy => true

  has_many :auths

  has_many :uploads

  # TODO сделать.
  #has_many :brands
  #has_many :models

  has_many :stats, :dependent => :destroy

  #has_many :comments
  
  [:phone, :name, :email_address, :postal_address, :car, :company, :order].each do |table_name|
    has_many "#{table_name}_transactions".to_sym
  end

  def self.current_user=(current_user)
    Thread.current[:current_user] = current_user
  end
  
  def self.current_user
    Thread.current[:current_user]
  end

  has_secure_password validations: false

  attr_accessor :password_required

  validates :password, 
    :presence => true, 
    :confirmation => true, 
    :length => { :minimum => 6 }, 
    if: -> { password_required }

  validates :password_confirmation, 
    :presence => true,
    if: -> { password_required }

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

  has_many :cars, :dependent => :destroy
  accepts_nested_attributes_for :cars, :allow_destroy => true 

  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :allow_destroy => true

  has_many :email_addresses, :dependent => :destroy
  accepts_nested_attributes_for :email_addresses, :allow_destroy => true

  has_many :phones, :dependent => :destroy
  accepts_nested_attributes_for :phones, :allow_destroy => true

  has_many :postal_addresses, :dependent => :destroy
  accepts_nested_attributes_for :postal_addresses, :allow_destroy => true

  has_many :companies, :dependent => :destroy
  accepts_nested_attributes_for :companies, :allow_destroy => true

  has_many :names, :dependent => :destroy
  accepts_nested_attributes_for :names, :allow_destroy => true

  has_many :orders, :dependent => :destroy
  accepts_nested_attributes_for :orders, :allow_destroy => true

  belongs_to :time_zone, validate: true
  validates :russian_time_zone_manual_id, :inclusion => { :in => Rails.configuration.russian_time_zones.keys.map(&:to_i) }, unless: Proc.new { |u| u.use_auto_russian_time_zone }

  # TODO позже разобраться (обнаружил как неиспользуемую ассоциацию)
  #has_many :documents, :as => :documentable, :class_name => "Transaction"

  validates :discount, :prepayment, :numericality => true
  validates :order_rule, :inclusion => { :in => Rails.configuration.user_order_rules.keys }
  validates :role, :inclusion => Rails.configuration.user_roles_keys

  # Financial
  has_one :account, :as => :accountable, :dependent => :destroy
  validates :account, :presence => true



  def send_password_reset
    generate_token(:password_reset_email_token)
    generate_token(:password_reset_sms_token)
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
      unless (account.debit + inorder_orders.inject(0){|summ, order| summ += order.order_cost}) * prepayment / 100.00 <= account.credit
        return
      end

      inorder_orders.each do |order|
        if (account.debit + order.order_cost) * prepayment / 100.00 <= account.credit
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

  # TODO удалить
  before_validation :set_relational_attributes

  def set_relational_attributes
    #if names
    #  names.each do |name|
    #    name.user = self
    #  end
    #end

    #if phones
    #  phones.each do |phone|
    #    phone.user = self
    #  end
    #end

    #if email_addresses
    #  email_addresses.each do |email_address|
    #    email_address.user = self
    #  end
    #end

    #if postal_addresses
    #  postal_addresses.each do |postal_address|
    #    postal_address.user = self
    #  end
    #end

    #if cars
    #  cars.each do |car|
    #    car.user = self
    #  end
    #end

    #if products
    #  products.each do |product|
    #    product.user = self
    #  end
    #end

    #if orders
    #  orders.each do |order|
    #    order.user = self
    #  end
    #end

  end




end
