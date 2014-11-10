class SpareCatalogToken < ActiveRecord::Base
  belongs_to :spare_catalog

  before_validation do
    self.name = name.mb_chars.upcase
  end
end
