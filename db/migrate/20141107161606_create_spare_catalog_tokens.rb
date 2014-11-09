class CreateSpareCatalogTokens < ActiveRecord::Migration
  def change
    create_table :spare_catalog_tokens do |t|
      t.references :spare_catalog, index: true
      t.string :name

      t.timestamps null: false
    end
  end
end
