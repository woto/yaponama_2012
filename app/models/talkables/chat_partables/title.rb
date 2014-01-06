class Talkables::ChatPartables::Title < ActiveRecord::Base
  has_one :part

  validates :title, presence: true
  validates :size, :inclusion => { :in => Rails.configuration.title_sizes.keys }
end
