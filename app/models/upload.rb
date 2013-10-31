class Upload < ActiveRecord::Base
  include Code_1AttrAccessorAndValidation
  include SetCreationReasonBasedOnCode_1
  include BelongsToSomebody
  has_and_belongs_to_many :pages
  before_save :update_asset_attributes
  mount_uploader :upload, UploadUploader
  include Rails.application.routes.url_helpers

  # Операции вырезания и поворота
  attr_accessor :operation
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :image_w, :image_h
  attr_accessor :angle

  def angle
    @angle.to_i || 0
  end

  after_update :process_image, if: -> { ['crop', 'rotate'].include? operation }
  
  def process_image
    upload.recreate_versions!
  end

  def to_jq_upload
    {
      "name" => read_attribute(:upload),
      "size" => upload.size,
      "url" => upload.url,
      "thumbnail_url" => upload.thumb.url,
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE",
      "crop_url" => crop_upload_path(self),
      "rotate_url" => rotate_upload_path(self),
      "image" => upload.image?(self)
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
