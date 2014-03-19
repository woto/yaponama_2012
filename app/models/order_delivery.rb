# encoding: utf-8
#
class OrderDelivery < ActiveRecord::Base

  include BelongsToSomebody
  include BelongsToCreator
  include RenameMeConcernFour

  attr_accessor :postal_address_type
  belongs_to :postal_address, autosave: true#, inverse_of: :payments
  validates :postal_address_type, :inclusion => { :in => ['new', 'old'] }
  validates :new_postal_address, associated: true, if: -> { postal_address_type == 'new' }
  validates :old_postal_address, associated: true, inclusion: { in: proc {|order_delivery| order_delivery.somebody.postal_addresses } }, if: -> { postal_address_type == 'old' }

  def to_label
    postal_address.try(:to_label)
  end

end
