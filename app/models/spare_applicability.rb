class SpareApplicability < ActiveRecord::Base

  include Concerns::BrandAttributes
  include Concerns::ModelAttributes
  include Concerns::GenerationAttributes
  include Concerns::ModificationAttributes
  include Concerns::SpareInfoAttributes

  validates :spare_info, presence: true
  validates :brand, presence: true
  validates :model, presence: true

  validates :spare_info, uniqueness: { scope: [:brand_id, :model_id, :generation_id, :modification_id] }

  def to_label
    "#{spare_info.try(:to_label)} - #{brand.try(:to_label)} - #{model.try(:to_label)} - #{generation.try(:to_label)} - #{modification.try(:to_label)}"
  end

  validate do
    unless brand.try(:is_brand?)
      errors[:brand] << 'Нельзя указать производителя, который не отмечен как выпускающий автомобили.'
    end
  end

end
