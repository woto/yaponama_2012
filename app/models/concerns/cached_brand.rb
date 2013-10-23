module CachedBrand
  extend ActiveSupport::Concern

  included do

    #serialize :cached_brand, JSON
    before_save :fill_cached_brand
    def fill_cached_brand
      self.cached_brand = brand.try(&:to_label)
    end

  end

end
