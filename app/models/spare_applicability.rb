class SpareApplicability < ActiveRecord::Base

  include BrandAttributes
  include ModelAttributes
  include GenerationAttributes
  include ModificationAttributes
  include SpareInfoAttributes

  validates :spare_info, presence: true
  validates :brand, presence: true
  validates :model, presence: true

  validates :spare_info, uniqueness: { scope: [:brand_id, :model_id, :generation_id, :modification_id] }

  def to_label
    "#{spare_info.to_label} - #{brand.to_label} - #{model.to_label} - #{generation.try(:to_label)} - #{modification.try(:to_label)}"
  end

  # TODO доработать когда окончательно разберусь с is_brand
  #validate do
  #  unless brand.try(:is_brand?)
  #    errors[:brand] << 'Нельзя указать производителя, который не отмечен как выпускающий автомобили.'
  #  end
  #end

end
