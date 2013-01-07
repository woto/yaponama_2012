class BrandUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  #process :scale => [300, 300, 'white']

  #def scale(width, height, background=:transparent, gravity='Center')
  #  manipulate! do |img|
  #    img.combine_options do |cmd|
  #      cmd.thumbnail "#{width}x#{height}>"
  #      if background == :transparent
  #        cmd.background "rgba(255, 255, 255, 0.0)"
  #      else
  #        cmd.background background
  #      end
  #      cmd.gravity gravity
  #      cmd.extent "#{width+100}x#{height+100}"
  #    end
  #    img = yield(img) if block_given?
  #    img
  #  end
  #end

  version :thumb do
    process :resize_to_fit => [100, 100]
  end

end
