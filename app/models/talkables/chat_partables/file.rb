class Talkables::ChatPartables::File < ActiveRecord::Base
  mount_uploader :file, FileUploader
  has_one :part

  validates :file, :title, presence: true
end
