module SpareCatalogAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :spare_catalog
    accepts_nested_attributes_for :spare_catalog

    def spare_catalog_attributes=(attr)
      if attr["name"].present?
        spare_catalog = SpareCatalog.where(name: attr["name"]).first
        if spare_catalog.present?
          self.spare_catalog = spare_catalog
        else
          self.spare_catalog = SpareCatalog.new(name: attr["name"])
        end
      else
        self.spare_catalog = nil
      end

    end

  end

end
