# encoding: utf-8
#
module CachedSpareInfo
  extend ActiveSupport::Concern

  included do

    before_save :fill_cached_spare_info
    def fill_cached_spare_info
      self.cached_spare_info = spare_info.try(&:to_label)
    end

  end

end
