class BrandUploader < ApplicationUploader
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # TODO! Переделать на путь как в ApplicationUploader
  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

end
