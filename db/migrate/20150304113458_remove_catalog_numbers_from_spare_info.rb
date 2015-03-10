class RemoveCatalogNumbersFromSpareInfo < ActiveRecord::Migration
  def change
    remove_column :spare_infos, :catalog_numbers, :string, array: true, default: []
  end
end
