module CachedParentBrand
  extend ActiveSupport::Concern

  included do

    #serialize :cached_parent_brand, JSON
    before_save :fill_cached_parent_brand
    def fill_cached_parent_brand
      self.cached_parent_brand = parent_brand.try(&:to_label)
    end

  end

end
