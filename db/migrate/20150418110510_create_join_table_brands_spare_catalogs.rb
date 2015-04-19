class CreateJoinTableBrandsSpareCatalogs < ActiveRecord::Migration
  def change
    create_join_table :spare_catalogs, :brands do |t|
      # t.index [:spare_catalog_id, :brand_id]
      # t.index [:brand_id, :spare_catalog_id]
    end
  end
end
