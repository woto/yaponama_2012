# encoding: utf-8
#
module CachedActualAddress
  extend ActiveSupport::Concern

  included do

    before_save :fill_cached_actual_address
    def fill_cached_actual_address
      self.cached_actual_address = actual_address.try(&:to_label)
    end

  end

end
