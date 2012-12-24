class Upload < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  before_save :update_asset_attributes
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

  private
  
  def update_asset_attributes
    if upload.present? && upload_changed?
      self.content_type = upload.file.content_type
      self.file_size = upload.file.size
    end
  end

end
