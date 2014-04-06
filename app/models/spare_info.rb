# encoding: utf-8
#
class SpareInfo < ActiveRecord::Base
  include Selectable
  include CachedBrand
  include BrandAttributes

  #validates :catalog_number, presence: true

  def to_label
    "#{catalog_number} (#{cached_brand})"
  end

  validates :catalog_number, :presence => true, uniqueness:  { case_sensitive: false, :scope => :brand_id }

end
