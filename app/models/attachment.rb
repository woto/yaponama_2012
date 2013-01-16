class Attachment < ActiveRecord::Base
  belongs_to :email
  mount_uploader :attachment, AttachmentUploader
end
