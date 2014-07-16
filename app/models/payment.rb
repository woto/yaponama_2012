# encoding: utf-8
#
class Payment < ActiveRecord::Base

  include BelongsToSomebody
  include BelongsToCreator
  include RenameMeConcernThree
  include RenameMeConcernFour

  validates :amount, numericality: { only_integer: true }

  attr_accessor :profile_type
  belongs_to :profile, :class_name => "Profile", autosave: true
  #belongs_to :profile#, autosave: true#, inverse_of: :payments
  validates :profile_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true # TODO проверить потом
  validates :new_profile, associated: true, if: -> { profile_type == 'new' }
  validates :old_profile, associated: true, inclusion: { in: proc {|payment| payment.somebody.profiles } }, if: -> { profile_type == 'old' }

  attr_accessor :postal_address_type
  validates :postal_address_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true # TODO проверить потом

  belongs_to :postal_address, autosave: true#, inverse_of: :payments
  validates :new_postal_address, associated: true, if: -> { payment_type == 'Sberbank' && postal_address_type == 'new' }
  validates :old_postal_address, associated: true, inclusion: { in: proc {|payment| payment.somebody.postal_addresses } }, if: -> { payment_type == 'Sberbank' && postal_address_type == 'old' }

  #belongs_to :company
  #accepts_nested_attributes_for :company

  validates :payment_type, :inclusion => { in: Rails.configuration.payment_systems.keys, message: 'пожалуйста выберите платежную систему.' }

  def payment_destination
    "Пополнение счета № #{somebody.pretty_id}"
  end

end
