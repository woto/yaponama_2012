class AddWeightToSpareCatalogTokens < ActiveRecord::Migration
  def change
    add_column :spare_catalog_tokens, :weight, :integer, default: 1
  end
end
