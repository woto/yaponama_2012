# encoding: utf-8
#
module CachedLegalAddress
  extend ActiveSupport::Concern

  included do

    before_save :fill_cached_legal_address
    def fill_cached_legal_address
      self.cached_legal_address = legal_address.try(&:to_label)
    end

  end

end
