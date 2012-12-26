class UploadUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb, :if => :image? do
    process :resize_to_fit => [270, 270]
  end

  protected

  def image?(upload)
    upload.content_type.include? 'image'
  end

end
