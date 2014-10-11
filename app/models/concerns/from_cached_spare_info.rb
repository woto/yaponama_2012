module FromCachedSpareInfo
  extend ActiveSupport::Concern

  included do

    before_save :fill_from_cached_spare_info
    def fill_from_cached_spare_info
      self.from_cached_spare_info = from_spare_info.try(&:to_label)
    end

  end

end
