class Profile < ActiveRecord::Base
  include BelongsToCreator
  include Transactionable

  belongs_to :user, inverse_of: :profiles

  #has_many :orders
  #has_many :order_profiles
  #has_many :orders, :through => :order_profiles

  FIELDS =  ['names', 'phones', 'email_addresses', 'passports']

  FIELDS.each do |field|
    instance_eval <<-CODE, __FILE__, __LINE__ + 1
      has_many :#{field}, :inverse_of => :profile
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

end
