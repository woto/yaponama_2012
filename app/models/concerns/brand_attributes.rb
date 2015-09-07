module Concerns::BrandAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :brand
    accepts_nested_attributes_for :brand

    def brand_attributes=(attr)
      if attr["name"].present?
        brand = Brand.where(name: attr["name"]).first
        if brand.present?
          self.brand = brand
        else
          self.brand = Brand.new(name: attr["name"], is_brand: attr["is_brand"])
        end
      else
        self.brand = nil
      end

    end

  end

end
