class Modification < ActiveRecord::Base
  has_paper_trail
  belongs_to :generation


  def to_label
    "#{generation.to_label} -> #{name}"
  end
end
