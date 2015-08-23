class AddAncestryToSpareCatalogGroups < ActiveRecord::Migration
  def change
    add_column :spare_catalog_groups, :ancestry, :string
  end
end
