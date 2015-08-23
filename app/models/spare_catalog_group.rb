class SpareCatalogGroup < ActiveRecord::Base
  has_ancestry
  has_many :spare_catalogs

  def to_label
    name
  end
end
