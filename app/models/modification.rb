class Modification < ActiveRecord::Base
  include ByCategoryConcern
  include BelongsToCreator

  belongs_to :generation, :inverse_of => :modifications
  validates :generation, :presence => true

  validates :name, :presence => true, uniqueness: { case_sensitive: false, :scope => :generation_id }

  has_many :cars, :inverse_of => :modification

  has_many :spare_applicabilities, dependent: :destroy

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
