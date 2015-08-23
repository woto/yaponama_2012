class AddSpareCatalogGroupToSpareCatalogs < ActiveRecord::Migration
  def change
    add_reference :spare_catalogs, :spare_catalog_group, index: true, foreign_key: true
  end
end
