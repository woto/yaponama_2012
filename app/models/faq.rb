class Faq < ActiveRecord::Base
  include BelongsToCreator

  def to_label
    question
  end

end
