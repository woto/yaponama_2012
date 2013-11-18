# encoding: utf-8
#
class Car < ActiveRecord::Base
  include BelongsToSomebody
  include BelongsToCreator
  include Transactionable
  include Selectable

  validates :vin_or_frame, :inclusion => { :in => Rails.configuration.vin_or_frame.keys }
  validates :vin, :uniqueness => { case_sensitive: false }, :allow_blank => true, :length => { :within => 17..17 }
  validates :frame, :uniqueness => { case_sensitive: false }, :allow_blank => true

  validates :god, :dverey, :numericality => { :only_integer => true }, :allow_blank => true

  include CachedBrand
  include CachedModel
  include CachedGeneration
  include CachedModification

  validates :brand, presence: true, associated: true
  validates :model, presence: true, associated: true

  include BrandAttributes
  include ModelAttributes
  include GenerationAttributes
  include ModificationAttributes

  def to_label
    raise 'Где это используется?'
    "#{vin} - #{frame} - #{car_number} - #{brand} - #{model} - #{generation} - #{modification} - #{god} - #{period} - #{dvigatel} - #{tip} - #{moschnost} - #{privod} - #{tip_kuzova} - #{kpp} - #{kod_kuzova} - #{kod_dvigatelya} - #{rinok} - #{komplektaciya} - #{dverey} - #{rul}"
  end

  include RenameMeConcern

end
