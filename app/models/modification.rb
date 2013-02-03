class Modification < ActiveRecord::Base
  include BelongsToCreator
  belongs_to :generation


  def to_label
    "#{generation.to_label} -> #{name}"
  end
end
