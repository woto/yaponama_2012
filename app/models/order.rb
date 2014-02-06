# encoding: utf-8
#
class Order < ActiveRecord::Base
  include BelongsToSomebody
  include BelongsToCreator
  include Transactionable
  include Selectable
  include RenameMeConcernThree
  include RenameMeConcernFour

  #validates :old_profile_id, :presence => true, if: -> { profile_type == 'old' }

  # Для возможности выбора имеющегося или добавления нового получателя, компании
  attr_accessor :profile_type
  validates :profile_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true # TODO сейчас Требуется для создания пустого заказа

  #has_many :order_profiles
  #has_many :profiles, :through => :order_profiles

  #belongs_to :delivery
  #belongs_to :name
  #belongs_to :phone
  #belongs_to :email
  #belongs_to :metro

  #belongs_to :company
  #accepts_nested_attributes_for :company

  belongs_to :profile, :inverse_of => :orders_where_is_profile, autosave: true
  validates :new_profile, presence: true, associated: true, if: -> { profile_type == 'new' }
  validates :old_profile, presence: true, associated: true, inclusion: { in: proc {|order| order.somebody.profiles } }, if: -> { profile_type == 'old' }

  include CachedProfile

  attr_accessor :postal_address_type
  validates :postal_address_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true # TODO allow_nil сейчас требуется чтобы создать пустой заказ

  belongs_to :postal_address, :inverse_of => :orders_where_is_postal_address, autosave: true
  validates :new_postal_address, presence: true, associated: true, if: -> { postal_address_type == 'new' }
  validates :old_postal_address, presence: true, associated: true, inclusion: { in: proc {|order| order.somebody.postal_addresses } }, if: -> { postal_address_type == 'old' }

  has_many :products, :dependent => :destroy

  def to_label
    "Заказ № #{token}"
  end

  before_create :generate_token

  def to_param
    token
  end

  def self.find(token)
    found = Order.where(:token => token).first
    raise ActiveRecord::RecordNotFound, "Заказ № #{token} не найден." unless found
    found
  end


  protected

  def generate_token
    self.token = loop do
      # Три случайных числа
      # -
      # День
      # -
      # Месяц
      # Последнее число года
      #
      # 000-00-000
 
      random_token = ''
      random_token += 3.times.map{ [*'0'..'9'].sample }.join
      random_token += '-'
      random_token += DateTime.now.strftime("%d-%m%y")
      random_token = random_token[0..8]+random_token[10]
      #random_token += 3.times.map { [*'0'..'9', *'А'..'Я'].sample }.join
      break random_token unless Order.where(token: random_token).exists?
      #random_token = SecureRandom.urlsafe_base64
      #break random_token unless Order.where(token: random_token).exists?
    end
  end

end
