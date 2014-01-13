# encoding: utf-8
#
class Payment < ActiveRecord::Base

  validates :amount, numericality: { only_integer: true }

  include BelongsToSomebody
  include BelongsToCreator

  belongs_to :profile#, autosave: true#, inverse_of: :payments
  validates :profile, presence: true, associated: true, if: -> { profile_type == 'new' }
  validates :profile, presence: true, associated: true, inclusion: { in: proc {|payment| payment.somebody.profiles } }, if: -> { profile_type == 'old' }

  accepts_nested_attributes_for :profile
  def profile_attributes=(attr)
    # Из-за того что Rails не предоставляет возожности 
    # обновлять belongs_to ассоциацию приходится делать так
    if attr['id']
      self.profile = Profile.find(attr["id"])
      self.profile.assign_attributes attr
    else
      super
    end
  end

  belongs_to :postal_address#, autosave: true#, inverse_of: :payments
  validates :postal_address, associated: true, if: -> { profile_type == 'new' }, allow_nil: true
  validates :postal_address, associated: true, inclusion: { in: proc {|payment| payment.somebody.postal_addresses } }, if: -> { postal_address_type == 'old' }, allow_nil: true

  accepts_nested_attributes_for :postal_address
  def postal_address_attributes=(attr)
    if attr['id']
      self.postal_address = PostalAddress.find attr["id"]
      self.postal_address.assign_attributes attr
    else
      super
    end
  end

  belongs_to :company

  validates :payment_type, :inclusion => { in: Rails.configuration.payment_systems.keys, message: 'пожалуйста выберите платежную систему.' }

  attr_accessor :profile_type
  validates :profile_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true

  attr_accessor :postal_address_type
  validates :postal_address_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true

  accepts_nested_attributes_for :company

  def payment_destination
    "Пополнение счета № #{somebody.pretty_id}"
  end

end
