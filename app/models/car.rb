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


  validate do
    unless brand.try(:is_brand?)
      errors[:brand] << 'Нельзя указать производителя, который не отмечен как выпускающий автомобили.'
    end
  end

  def to_label
    res = []
    res << vin
    res << frame
    res << brand.try(:to_label)
    res << model.try(:to_label)
    res << generation.try(:to_label)
    res << modification.try(:to_label)
    res.reject(&:blank?).join(', ')
  end

end
