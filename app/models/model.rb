class Model < ActiveRecord::Base
  include ByCategoryConcern
  include BelongsToCreator

  belongs_to :brand, :inverse_of => :models
  validates :brand, :presence => true

  validates :name, :presence => true, uniqueness:  { case_sensitive: false, :scope => :brand_id }

  has_many :generations, :dependent => :destroy, :inverse_of => :model

  has_many :cars, :inverse_of => :model

  has_many :spare_applicabilities, dependent: :destroy

  validate do
    unless brand.try(:is_brand?)
      errors[:brand] << 'Нельзя указать производителя, который не отмечен как выпускающий автомобили'
    end
  end

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
