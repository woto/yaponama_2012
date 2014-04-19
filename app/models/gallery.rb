class Gallery < ActiveRecord::Base
  include BelongsToCreator

  mount_uploader :image, GalleryUploader

  def to_label
    title
  end

end
