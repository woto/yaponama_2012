# encoding: utf-8
#
class Somebody < ActiveRecord::Base

  include BelongsToCreator
  include Selectable

  belongs_to :place, class_name: "Deliveries::Place"

  has_many :payments
  has_many :order_deliveries

  has_many :uploads

  # Понятие главного профиля
  belongs_to :profile, inverse_of: :user_where_is_profile
  accepts_nested_attributes_for :profile

  #validates :profile, presence: true, unless: -> { role == 'guest' } (Пользователь может входить с помощью социальных сетей не имея профиля в начала)

  has_many :talks, inverse_of: :somebody
  accepts_nested_attributes_for :talks

  has_many :talks_where_i_am_addresse, class_name: "Talk"

  # TODO сделать.
  #has_many :brands
  #has_many :models

  has_many :stats, :dependent => :destroy, inverse_of: :somebody, after_add: :save_first_referrer

  # Особый случай с talks (Очередность проаверки условий важна! 
  # Потратил 4 часа на то чтобы поменять местами условия if)
  before_validation if: -> {code_1 == 'chat' && profile} do
    profile.code_1 = code_1 
  end


  def save_first_referrer(stat)
    if stats.length == 1
      self.first_referrer = stat.referrer
      save!
    end
  end

  #has_many :comments
  
  [:name, :phone, :email, :passport, :postal_address, :car, :company, :order, :profile, :product].each do |table_name|
    has_many "#{table_name}_transactions".to_sym, :inverse_of => :somebody
  end

  def self.current_user=(current_user)
    Thread.current[:current_user] = current_user
  end
  
  def self.current_user
    Thread.current[:current_user]
  end

  include PasswordValidations

  include Tokenable
  before_create do 
    generate_token(:auth_token, :long)
  end


  has_many :auths, :dependent => :destroy, :inverse_of => :somebody

  has_many :cars, :dependent => :destroy, inverse_of: :somebody
  accepts_nested_attributes_for :cars, :allow_destroy => true 

  has_many :products, :dependent => :destroy, inverse_of: :somebody
  accepts_nested_attributes_for :products, :allow_destroy => true

  has_many :emails, :dependent => :destroy, inverse_of: :somebody
  #accepts_nested_attributes_for :emails, :allow_destroy => true

  # TODO ПЕРЕДЕЛАТЬ!
  has_many :phones, :dependent => :destroy, inverse_of: :somebody
  #accepts_nested_attributes_for :phones, :allow_destroy => true

  has_many :calls, :dependent => :destroy, inverse_of: :somebody

  has_many :passports, :dependent => :destroy, inverse_of: :somebody
  #accepts_nested_attributes_for :passports, :allow_destroy => true

  has_many :names, :dependent => :destroy, inverse_of: :somebody
  #accepts_nested_attributes_for :names, :allow_destroy => true

  has_many :postal_addresses, :dependent => :destroy, inverse_of: :somebody
  accepts_nested_attributes_for :postal_addresses, :allow_destroy => true

  has_many :companies, :dependent => :destroy, inverse_of: :somebody
  accepts_nested_attributes_for :companies, :allow_destroy => true

  has_many :profiles, :dependent => :destroy, inverse_of: :somebody
  accepts_nested_attributes_for :profiles, :allow_destroy => true

  has_many :orders, :dependent => :destroy, inverse_of: :somebody
  accepts_nested_attributes_for :orders, :allow_destroy => true

  validates :russian_time_zone_manual_id, :inclusion => { :in => Rails.configuration.russian_time_zones.keys.map(&:to_i) }, unless: Proc.new { |u| u.use_auto_russian_time_zone }

  # Financial
  has_one :account, :dependent => :destroy, inverse_of: :somebody
  #validates :account, :presence => true

  def pass_my_attributes_to_somebody_and_destroy_self new_user

    # Переносим историю
    stats.each do |stat|
      stat.somebody = new_user
      stat.save
    end

    stats.reload

    ###

    # Переносим диалоги
    talks.each do |talk|
      if talk.creator == self
        talk.creator = new_user
      end
      talk.somebody = new_user
      talk.save
    end

    talks.reload

    ###

    # TODO Разобраться с counters
    #User.reset_counters(new_user.id, :talks)
    #new_user.total_talks = new_user.talks.length
    #new_user.unread_talks = new_user.talks.where(read: false).length
    #
    # Переносим профили
    profiles.each do |profile|
      profile.somebody = new_user
      profile.save
    end

    profiles.reload


    # Переносим имена
    names.each do |name|
      name.somebody = new_user
      name.save
    end

    names.reload

    # Переносим телефоны
    phones.each do |phone|
      phone.somebody = new_user
      phone.save
    end

    phones.reload

    # Переносим emails
    emails.each do |email|
      email.somebody = new_user
      email.save
    end

    emails.reload

    # Переносим паспорта
    passports.each do |passport|
      passport.somebody = new_user
      passport.save
    end
    
    passports.reload

    # Переносим почтовые адреса
    postal_addresses.each do |postal_address|
      postal_address.somebody = new_user
      postal_address.save
    end

    postal_addresses.reload


    # Переносим компании
    companies.each do |company|
      company.somebody = new_user
      company.save
    end

    companies.reload

    # Переносим заказы
    orders.each do |order|
      order.somebody = new_user
      order.save
    end

    orders.reload

    # Переносим товары
    products.each do |product|
      product.somebody = new_user
      product.save
    end

    products.reload

    # TODO !!!
    new_user.save
    #self.destroy
  end

  def pretty_id
    id.to_s.scan(/.{2}|.+/).join("-")
  end

  def to_label
    
    if (full_name = [surname, name]).any?
      full_name.join(' ')
    else
      "Посетитель: № #{pretty_id}"
    end
  end

  def name
    begin
      JSON.parse(cached_profile).try(:[], 'names').try(:first).try(:[], 'name')
    rescue
      # Потом устранить
    end
  end

  def surname
    begin
      JSON.parse(cached_profile).try(:[], 'names').try(:first).try(:[], 'surname')
    rescue
      # Потом устранить
    end
  end


  #attr_accessor :update_cached_profile

  include CachedProfile

  include Code_1AttrAccessorAndValidation
  include SetCreationReasonBasedOnCode_1

  ########################################################################

  attr_accessor :code_2

  validates :code_2, presence: true, inclusion: { in: ['phone', 'email'] }, if: -> { code_1 == 'register' }

  ########################################################################

  include Transactionable

  ########################################################################

  def seller?
    ['manager', 'admin'].include? role
  end

  def buyer?
    ['guest', 'user'].include? role
  end

end
