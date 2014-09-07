class RemoveCatalogManufacturerPathFromBrands < ActiveRecord::Migration
  def change
    remove_column :brands, :catalog, :string
    remove_column :brands, :manufacturer, :string
    remove_column :brands, :path, :string
  end
end
