# encoding: utf-8
#
class Profile < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
  include Selectable
  #include ConfirmRequired
  
  read_only :creation_reason

  #has_many :payments, inverse_of: :profile

  validates :somebody, presence: true#, associated: true
  has_one :user_where_is_profile, class_name: "Somebody", inverse_of: :profile
  #accepts_nested_attributes_for :user_where_is_profile

  FIELDS =  ['names', 'phones', 'emails', 'passports']

  has_many :names, inverse_of: :profile, dependent: :destroy
  accepts_nested_attributes_for :names, allow_destroy: true

  has_many :phones, inverse_of: :profile, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: :reject_contacts

  has_many :emails, inverse_of: :profile, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true, reject_if: :reject_contacts

  has_many :passports, inverse_of: :profile, dependent: :destroy
  accepts_nested_attributes_for :passports, allow_destroy: true

  # Если не регистрация, то отвергаем/удаляем
  def reject_contacts(attributes)
    unless ['register'].include? creation_reason
      exists = attributes['id'].present?
      empty = attributes['value'].blank?
      attributes.merge!({:_destroy => 1}) if exists and empty
      return (!exists and empty)
    end
  end

  ## Если имеются ошибки, и пишем в чате. То создаем заново поля для ввода
  #after_validation if: -> {errors.present?} do
  #  if somebody.profile.emails.blank?
  #    somebody.profile.emails.new
  #  end
  #  if somebody.profile.phones.blank?
  #    somebody.profile.phones.new
  #  end
  #end

  ## Если пишем в чате и не заполнен ни email, ни телефон
  #validate if: -> {creation_reason == 'talk'} do


  validate do
    email = emails.reject{|r| r.marked_for_destruction?}.first
    phone = phones.reject{|r| r.marked_for_destruction?}.first
    if phone.try(:value).blank? && email.try(:value).blank?
      errors.add(:base, 'укажите телефон и/или email')
    end
  end

  ## Если имеются ошибки, и пишем в чате. То создаем заново поля для ввода
  #after_validation if: -> {errors.present? && creation_reason == 'talk'} do
  #  binding.pry
  #  if emails.blank?
  #    emails.new
  #  end
  #  if phones.blank?
  #    phones.new
  #  end
  #end


  before_validation do
    # 1. (somebody != user_where_is_profile) Если не делаю такой
    # проверки, то code_1  перетирается
    # 2. В какой-то момент это опять больше не потребовалось
    if user_where_is_profile.present?
      self.somebody = user_where_is_profile
    end
  end

  has_one :user_where_is_profile, :class_name => "Somebody", :foreign_key => :profile_id, :inverse_of => :profile
  has_many :orders_where_is_profile, :class_name => "Order", :foreign_key => :profile_id, :inverse_of => :profile

  before_save do
    self.cached_names = names.to_json(only: [:surname, :name, :patronymic])
    self.cached_phones = phones.to_json(only: :value)
    self.cached_emails = emails.to_json(only: :value)
    self.cached_passports = passports.to_json(only: [:seriya, :nomer, :mesto_rozhdeniya])
  end

  after_create do
    # Если профиль единственный, то он становится главным
    if somebody.profiles.length == 1
      self.user_where_is_profile = somebody
    end
  end

  after_save do

    if user_where_is_profile.present?
      user_where_is_profile.cached_profile_will_change!
      user_where_is_profile.save
    end

    orders_where_is_profile.each do |order|
      order.cached_profile_will_change!
      order.save
    end

  end

  after_destroy do

    if user_where_is_profile.present?
      self.user_where_is_profile.profile = user_where_is_profile.profiles.first
      user_where_is_profile.save
    end

    if orders_where_is_profile.present?
      raise 'TODO TODO Сделать что-то'
    end

  end

  # Транзакции необходимо подключать в конце, т.к. очередность callback'ов важна.
  # В частности сначала мы должны сгенерировать cached_names, ..., а потом записывать
  # транзакцию, а не наоборот
  include Transactionable

  def to_label
    if cached_names
      "#{JSON.parse(cached_names).first['surname']} #{JSON.parse(cached_names).first['name']} #{JSON.parse(cached_names).first['patronymic']}"
    end
  end

  before_destroy do
    if somebody.profiles.length <= 1
      errors.add(:base, 'Нельзя удалить последний профиль')
      false
    end
  end

end
