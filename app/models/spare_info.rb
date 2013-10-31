class SpareInfo < ActiveRecord::Base
  include Selectable
  include CachedBrand
  include BrandAttributes
end
