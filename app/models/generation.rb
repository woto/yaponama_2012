# encoding: utf-8
#
class Generation < ActiveRecord::Base
  include Selectable
  include BelongsToCreator
  include CachedModel

  belongs_to :model, :inverse_of => :generations
  validates :model, :presence => true

  validates :name, :presence => true, uniqueness:  { case_sensitive: false, :scope => :model_id }

  has_many :cars, :inverse_of => :generation

  has_many :modifications, :inverse_of => :generation, :dependent => :destroy

  has_many :spare_applicabilities, dependent: :destroy

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  after_save :update_all_cached_generation

  def update_all_cached_generation
    spare_applicabilities.update_all(cached_generation: name)
    cars.update_all(cached_generation: name)
    modifications.update_all(cached_generation: name)
  end

end
