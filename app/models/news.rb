class News < ActiveRecord::Base
  include BelongsToCreator

  def to_param
    "#{id}-#{path.parameterize}"
  end

  def to_label
    title
  end
end
