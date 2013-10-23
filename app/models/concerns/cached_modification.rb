module CachedModification
  extend ActiveSupport::Concern

  included do

    before_save :fill_cached_modification
    def fill_cached_modification
      self.cached_modification = modification.try(&:to_label)
    end

  end

end
