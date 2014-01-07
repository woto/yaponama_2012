# encoding: utf-8
#
class Somebody < ActiveRecord::Base

  include BelongsToCreator
  include Selectable

  belongs_to :place, class_name: "Deliveries::Place"

  has_many :uploads

  # Понятие главного профиля
  belongs_to :main_profile, :class_name => "Profile", :inverse_of => :user_where_is_main_profile

  #validates :main_profile, presence: true, unless: -> { role == 'guest' } (Пользователь может входить с помощью социальных сетей не имея профиля в начала)

  belongs_to :default_addressee, class_name: "Somebody"

  has_many :talks, inverse_of: :somebody
  accepts_nested_attributes_for :talks

  has_many :talks_where_i_am_addresse, class_name: "Talk"

  # TODO сделать.
  #has_many :brands
  #has_many :models

  has_many :stats, :dependent => :destroy, inverse_of: :somebody, after_add: :save_first_referrer

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

  def to_label
    res = []
    
    begin
      name = JSON.parse(cached_main_profile)['names'].first
      [name['surname'], name['name']].join(' ')
    rescue
      "Посетитель № #{id.to_s.scan(/.{2}|.+/).join("-")}"
    end
  end

  def name
    begin
      JSON.parse(cached_main_profile).try(:[], 'names').try(:first).try(:[], 'name')
    rescue
      # Потом устранить
    end
  end


  #attr_accessor :update_cached_main_profile

  before_save do
    if main_profile_id_changed?
      self.cached_main_profile_will_change!
    end
  end

  before_save do
    if cached_main_profile_changed?
      cached_main_profile = {}
      Profile::FIELDS.each do |field|
        instance_eval <<-CODE, __FILE__, __LINE__ + 1
          cached_main_profile[field] = JSON.parse(main_profile.cached_#{field})
        CODE
      end
      self.cached_main_profile = cached_main_profile.to_json
    end
  end

  include Code_1AttrAccessorAndValidation
  include SetCreationReasonBasedOnCode_1

  ########################################################################

  attr_accessor :code_2

  validates :code_2, presence: true, inclusion: { in: ['phone', 'email'] }, if: -> { code_1 == 'register' }

  ########################################################################

  include Transactionable

  ########################################################################

  after_save do
    if (['admin', 'manager'].include?(role_was) || ['admin', 'manager'].include?(role) ) && changes.present?
      $redis.publish("#{Rails.env}:update sellers", JSON.dump(comment: changes))
    end
  end

end
