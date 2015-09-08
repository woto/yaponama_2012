module Concerns::SpareInfoAttributes
  extend ActiveSupport::Concern
  included do

    belongs_to :spare_info
    accepts_nested_attributes_for :spare_info

    def spare_info_attributes=(attr)
      if attr["name"].present?
        spare_info = SpareInfo.where(name: attr["name"]).first
        if spare_info.present?
          self.spare_info = spare_info
        else
          self.spare_info = SpareInfo.new(name: attr["name"], phantom: true)
        end
      else
        self.spare_info = nil
      end

    end
  end

end
