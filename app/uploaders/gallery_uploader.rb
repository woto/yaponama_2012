class GalleryUploader < ApplicationUploader

  version :welcome do
    process :resize_to_fit => [750, 750]
  end

end
