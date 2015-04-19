class RemoveCachedSpareCatalogFromSpareInfos < ActiveRecord::Migration
  def change
    remove_column :spare_infos, :cached_spare_catalog, :string
  end
end
