class Profile < ActiveRecord::Base
  include BelongsToCreator

  belongs_to :user, inverse_of: :profiles
  validates :user, presence: true, associated: true

  #has_many :orders
  #has_many :order_profiles
  #has_many :orders, :through => :order_profiles

  validates :names, :phones, presence: true
  validates :passports, :names, length: { maximum: 1}

  FIELDS =  ['names', 'phones', 'email_addresses', 'passports']

  FIELDS.each do |field|
    instance_eval <<-CODE, __FILE__, __LINE__ + 1
      has_many :#{field}, :inverse_of => :profile, :dependent => :destroy
      accepts_nested_attributes_for :#{field},
        :allow_destroy => true,
        :reject_if => :all_blank
    CODE
  end

  before_save :fill_cached_fields_before_save
  def fill_cached_fields_before_save
    FIELDS.each do |field|
      instance_eval "self.cached_#{field} = #{field}.map(&:to_label).join(', ')"
    end
  end

  def prepare_profile

    if names.blank?
      names.new
    end

    if email_addresses.blank?
      email_addresses.new
    end

    if phones.blank?
      phones.new
    end

    if passports.blank?
      passports.new
    end

  end
  # Транзакции необходимо подключать в конце, т.к. очередность callback'ов важна.
  # В частности сначала мы должны сгенерировать cached_names, ..., а потом записывать
  # транзакцию, а не наоборот
  include Transactionable
  include RenameMeConcern

end
