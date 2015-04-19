# encoding: utf-8
#
class Model < ActiveRecord::Base
  include Selectable
  include BelongsToCreator

  belongs_to :brand, :inverse_of => :models
  validates :brand, :presence => true

  validates :name, :presence => true, uniqueness:  { case_sensitive: false, :scope => :brand_id }

  has_many :generations, :dependent => :destroy, :inverse_of => :model

  has_many :cars, :inverse_of => :generation

  has_many :spare_applicabilities, dependent: :destroy

  ## TODO Написать для этого тест(?!)
  #validate do
  #  if brand.try(:brand).present?
  #    errors[:base] << 'Нельзя указывать в качестве производителя синоним'
  #  end
  #end

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  after_save :update_all_cached_model

  def update_all_cached_model
    spare_applicabilities.update_all(cached_model: name)
    cars.update_all(cached_model: name)
    generations.update_all(cached_model: name)
  end

end
