# encoding: utf-8
#
module CachedModel
  extend ActiveSupport::Concern

  included do

    before_save :fill_cached_model
    def fill_cached_model
      self.cached_model = model.try(&:to_label)
    end

  end

end
