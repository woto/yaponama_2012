# encoding: utf-8
#
class Talkables::Letter < ActiveRecord::Base
  has_one :talk, as: :talkable
  #has_many :letter_parts
  mount_uploader :letter, LetterUploader
  include BelongsToSomebody
  belongs_to :email
end
