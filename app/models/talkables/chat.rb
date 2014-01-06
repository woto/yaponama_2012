# encoding: utf-8
#
class Talkables::Chat < ActiveRecord::Base
  has_one :talk, as: :talkable
  has_many :chat_parts
  accepts_nested_attributes_for :chat_parts
end
