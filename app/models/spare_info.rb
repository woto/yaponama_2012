# encoding: utf-8
#
class SpareInfo < ActiveRecord::Base
  include Selectable
  include CachedBrand
  include BrandAttributes

  validates :catalog_number, presence: true

  def to_label
    "#{catalog_number} (#{cached_brand})"
  end

end
