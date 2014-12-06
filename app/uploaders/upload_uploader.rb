class UploadUploader < ApplicationUploader
  process :crop
  process :rotate

  def rotate
    if model.operation == 'rotate'
      manipulate! do |img|
        img.rotate(model.angle)
      end
    end
  end

  def crop
    if model.operation == 'crop'
      manipulate! do |img|
        x_ratio = img.width.to_f / model.image_w.to_f
        y_ratio = img.height.to_f / model.image_h.to_f
        x = model.crop_x.to_f * x_ratio
        y = model.crop_y.to_f * y_ratio
        w = model.crop_w.to_f * x_ratio
        h = model.crop_h.to_f * y_ratio
        crop_params = "#{w}x#{h}+#{x}+#{y}"
        img.crop(crop_params)
        img
      end
    end
  end

end
