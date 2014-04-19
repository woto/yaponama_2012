class GalleryUploader < ApplicationUploader

  version :welcome do
    process :resize_to_fit => [1024, 1024]
  end

  version :teaser do
    process :resize_to_fit => [100, 100]
  end

end
