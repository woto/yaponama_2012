# encoding: utf-8
#
module CachedSpareCatalog
  extend ActiveSupport::Concern

  included do

    #serialize :cached_spare_catalog, JSON
    before_save :fill_cached_spare_catalog
    def fill_cached_spare_catalog
      self.cached_spare_catalog = spare_catalog.try(&:to_label)
    end

  end

end
