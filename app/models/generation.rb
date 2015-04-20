# encoding: utf-8
#
class Generation < ActiveRecord::Base
  include ByCategoryConcern
  include Selectable
  include BelongsToCreator

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

end
