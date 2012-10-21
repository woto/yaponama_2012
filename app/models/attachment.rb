class Attachment < ActiveRecord::Base
  belongs_to :email
  attr_accessible :attachment
  mount_uploader :attachment, AttachmentUploader
end
