# encoding: utf-8
#
class Profile < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
  include Selectable
  #include ConfirmRequired

  #has_many :payments, inverse_of: :profile

  validates :somebody, presence: true#, associated: true
  has_one :user_where_is_profile, class_name: "Somebody", inverse_of: :profile
  accepts_nested_attributes_for :user_where_is_profile

  FIELDS =  ['names', 'phones', 'emails', 'passports']

  FIELDS.each do |field|
    instance_eval <<-CODE, __FILE__, __LINE__ + 1
      #serialize :cached_#{field}, JSON
      has_many :#{field}, inverse_of: :profile, dependent: :destroy
      accepts_nested_attributes_for :#{field},
        :allow_destroy => true,
        :reject_if => :all_blank
    CODE
  end


  before_validation do
    # 1. (somebody != user_where_is_profile) Если не делаю такой
    # проверки, то code_1  перетирается
    # 2. В какой-то момент это опять больше не потребовалось
    if user_where_is_profile.present?
      self.somebody = user_where_is_profile
    end
  end

  # Если оба (email и phone пустые, в процессе обращения в службу поддержки)
  after_validation do
    if ['chat'].include? code_1
      email = emails.first
      phone = phones.first
      if (phone.try(:value).blank? || phone.try(:marked_for_destruction?)) && (email.try(:value).blank? || email.try(:marked_for_destruction?))
        if email
          email.errors.add(:value, '')
        else
          emails.new.errors.add(:value, '')
        end
        if phone
          phone.errors.add(:value, '')
        else
          phones.new.errors.add(:value, '')
        end
        self.errors.add(:base, 'укажите телефон и/или email')
      end
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
      errors.add(:base, 'unable')
      false
    end
  end


  include RenameMeConcern

end
