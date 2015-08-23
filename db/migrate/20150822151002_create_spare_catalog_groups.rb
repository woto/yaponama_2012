class CreateSpareCatalogGroups < ActiveRecord::Migration
  def change
    create_table :spare_catalog_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
