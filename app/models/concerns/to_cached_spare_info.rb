module ToCachedSpareInfo
  extend ActiveSupport::Concern

  included do

    before_save :fill_to_cached_spare_info
    def fill_to_cached_spare_info
      self.to_cached_spare_info = to_spare_info.try(&:to_label)
    end

  end

end
