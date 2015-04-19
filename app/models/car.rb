# encoding: utf-8
#
class Car < ActiveRecord::Base
  include BelongsToSomebody
  include BelongsToCreator
  include Transactionable
  include Selectable
  include BrandAttributes
  include ModelAttributes
  include GenerationAttributes
  include ModificationAttributes

  read_only :creation_reason

  validates :vin_or_frame, :inclusion => { :in => Rails.configuration.vin_or_frame.keys }
  validates :vin, :uniqueness => { case_sensitive: false }, :allow_blank => true, :length => { :within => 17..17 }
  validates :frame, :uniqueness => { case_sensitive: false }, :allow_blank => true

  validates :god, :dverey, :numericality => { :only_integer => true }, :allow_blank => true

  validates :brand, presence: true, associated: true
  validates :model, presence: true, associated: true

  ## TODO Написать для этого тест(?!)
  #validate do
  #  if brand.try(:brand).present?
  #    errors[:base] << 'Нельзя указывать в качестве производителя синоним'
  #  end
  #end

  def to_label
    res = []
    res << vin
    res << frame
    res << cached_brand
    res << cached_model
    res << cached_generation
    res << cached_modification
    res.reject(&:blank?).join(', ')
  end

end
