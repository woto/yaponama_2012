class Gallery < ActiveRecord::Base

  mount_uploader :image, GalleryUploader

  def to_label
    title
  end

end
