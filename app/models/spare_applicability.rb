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
    "#{cached_spare_info} - #{cached_brand} - #{cached_model} - #{cached_generation} - #{cached_modification}"
  end

  ## TODO Написать для этого тест(?!)
  #validate do
  #  if brand.try(:brand).present?
  #    errors[:base] << 'Нельзя указывать в качестве производителя синоним'
  #  end
  #end

end
