class Company < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser

  attr_accessor :legal_address_type, :actual_address_type

  belongs_to :legal_address, :class_name => 'PostalAddress'
  validates :legal_address, :presence => true
  accepts_nested_attributes_for :legal_address

  belongs_to :actual_address, :class_name => 'PostalAddress'
  validates :actual_address, :presence => true
  accepts_nested_attributes_for :actual_address

  validates :name, :inn, :presence => true

  before_validation :set_relational_attributes

  def set_relational_attributes
    if legal_address
      legal_address.user = user
    end

    if actual_address
      actual_address.user = user
    end
  end

end
