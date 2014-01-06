class Talkables::ChatPartables::Text < ActiveRecord::Base
  has_one :part

  validates :text, presence: true
end
