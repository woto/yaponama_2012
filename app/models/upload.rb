class Upload < ActiveRecord::Base
  attr_accessible :upload
  mount_uploader :upload, UploadUploader
  before_save :update_upload_attributes

  include Rails.application.routes.url_helpers


  def to_jq_upload
    {
      "name" => read_attribute(:upload),
      "size" => read_attribute(:file_size),
      "url" => upload.url(:thumb),
      "thumbnail_url" => upload.url(:thumb),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end

  private
  
  def update_upload_attributes
    if upload.present? && upload_changed?
      self.content_type = upload.file.content_type
      self.file_size = upload.file.size
    end
  end

end
