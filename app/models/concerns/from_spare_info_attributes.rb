module FromSpareInfoAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :from_spare_info, class_name: "SpareInfo"
    accepts_nested_attributes_for :from_spare_info

    def from_spare_info_attributes=(attr)
      if attr["name"].present?
        spare_info = SpareInfo.where(name: attr["name"]).first
        if spare_info.present?
          self.from_spare_info = spare_info
        else
          self.from_spare_info = SpareInfo.new(name: attr["name"], phantom: true)
        end
      else
        self.from_spare_info = nil
      end

    end
  end

end
