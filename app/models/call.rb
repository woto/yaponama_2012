class Call < ActiveRecord::Base
  belongs_to :phone
  mount_uploader :file, UploadUploader
end
