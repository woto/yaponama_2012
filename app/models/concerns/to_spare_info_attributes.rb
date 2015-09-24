module Concerns::ToSpareInfoAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :to_spare_info, class_name: "SpareInfo"
    accepts_nested_attributes_for :to_spare_info

    def to_spare_info_attributes=(attr)
      if attr["name"].present?
        catalog_number, brand = attr["name"].match(/(.+) \((.+)\)/)[1,2]
        spare_info = SpareInfo.joins(:brand).where(catalog_number: catalog_number).where(brands: {name: brand}).first
        if spare_info.present?
          self.to_spare_info = spare_info
        else
          raise 'Тут пока что нельзя создавать SpareInfo'
          self.to_spare_info = SpareInfo.new(name: attr["name"])
        end
      else
        self.to_spare_info = nil
      end

    end
  end

end
