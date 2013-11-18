# encoding: utf-8
#
module CachedGeneration
  extend ActiveSupport::Concern

  included do

    before_save :fill_cached_generation
    def fill_cached_generation
      self.cached_generation = generation.try(&:to_label)
    end

  end

end
