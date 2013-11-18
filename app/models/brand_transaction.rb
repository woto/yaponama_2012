# encoding: utf-8
#
class BrandTransaction < ActiveRecord::Base

  mount_uploader :image_before, BrandUploader
  mount_uploader :image_after, BrandUploader

end
