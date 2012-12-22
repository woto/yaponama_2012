class Upload < ActiveRecord::Base
  attr_accessible :upload
  mount_uploader :upload, UploadUploader

  include Rails.application.routes.url_helpers


  def to_jq_upload
    {
      "name" => read_attribute(:upload),
      "size" => upload.size,
      "url" => upload.url,
      "thumbnail_url" => upload.thumb.url,
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end

end
