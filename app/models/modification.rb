class Modification < ActiveRecord::Base
  belongs_to :generation

  validates :name, :generation, :presence => true


  def to_label
    "#{generation.to_label} -> #{name}"
  end
end
