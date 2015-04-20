module ByCategoryConcern

  extend ActiveSupport::Concern

  included do
    scope :by_category, ->(id) {
      joins(:spare_applicabilities => :spare_info).
      where(spare_infos: {spare_catalog_id: id.to_i})
    }
  end

end
