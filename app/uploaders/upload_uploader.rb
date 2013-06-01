class UploadUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :crop
  process :rotate

  version :thumb, if: :image? do
    process :resize_to_fit => [100, 100]
  end


  def rotate
    if model.operation == 'rotate'
      manipulate! do |img|
        img.rotate!(model.angle)
      end
    end
  end

  def crop
    if model.operation == 'crop'
      img = ::Magick::Image::read(self.path).first
      file_w = img.columns
      file_h = img.rows
      x_ratio = file_w.to_f / model.image_w.to_f
      y_ratio = file_h.to_f / model.image_h.to_f
      manipulate! do |img|
        x = model.crop_x.to_f * x_ratio
        y = model.crop_y.to_f * y_ratio
        w = model.crop_w.to_f * x_ratio
        h = model.crop_h.to_f * y_ratio
        img.crop!(x, y, w, h)
      end
    end
  end

  def image?(upload)
    upload.content_type.include? 'image'
  end

end
