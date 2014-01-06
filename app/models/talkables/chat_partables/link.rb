class Talkables::ChatPartables::Link < ActiveRecord::Base
  has_one :part

  validates :url, :title, presence: true
  validates :target, :inclusion => { :in => Rails.configuration.link_targets.keys }
end
