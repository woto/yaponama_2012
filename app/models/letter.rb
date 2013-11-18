# encoding: utf-8
#
class Letter < ActiveRecord::Base
  mount_uploader :letter, LetterUploader
  include BelongsToSomebody
  belongs_to :email
  has_one :talk, as: :talkable
  has_many :letter_parts

  def to_label
    "/letters/#{id}"
  end
end
