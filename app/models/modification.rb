# encoding: utf-8
#
class Modification < ActiveRecord::Base
  include Selectable
  include BelongsToCreator
  include CachedGeneration

  belongs_to :generation, :inverse_of => :modifications
  validates :generation, :presence => true

  validates :name, :presence => true, uniqueness: { case_sensitive: false, :scope => :generation_id }

  has_many :cars, :inverse_of => :generation

  def to_label
    name
  end

  after_save :update_all_cached_modification

  def update_all_cached_modification
    cars.update_all(cached_modification: name)
  end

end
