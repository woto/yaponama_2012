# TODO объединить from_spare_info_attributes, to_spare_info_attributes, spare_info_attributes
module Concerns::SpareInfoAttributes
  extend ActiveSupport::Concern
  included do

    belongs_to :spare_info
    accepts_nested_attributes_for :spare_info

    def spare_info_attributes=(attr)
      if attr["name"].present?
        catalog_number, brand = attr["name"].match(/(.+) \((.+)\)/)[1,2]
        spare_info = SpareInfo.joins(:brand).where(catalog_number: catalog_number).where(brands: {name: brand}).first
        if spare_info.present?
          self.spare_info = spare_info
        else
          raise 'Тут пока что нельзя создавать SpareInfo'
          self.spare_info = SpareInfo.new(name: attr["name"], phantom: true)
        end
      else
        self.spare_info = nil
      end

    end
  end

end
