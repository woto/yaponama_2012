# encoding: utf-8
#
class Chat < ActiveRecord::Base
  has_one :talk, as: :talkable

  def to_label
    content
  end
end
