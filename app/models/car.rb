class Car < ActiveRecord::Base

  include BelongsToCreator
  include BelongsToUser
  include Concerns::BrandAttributes
  include Concerns::ModelAttributes
  include Concerns::GenerationAttributes
  include Concerns::ModificationAttributes

  validates :vin_or_frame, :inclusion => { :in => ['vin', 'frame'] }
  #validates :vin, :length => {:within => 17..17}, if: -> {vin_or_frame == 'vin'}

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
