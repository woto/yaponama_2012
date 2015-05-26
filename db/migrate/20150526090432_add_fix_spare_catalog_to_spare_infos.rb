class AddFixSpareCatalogToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :fix_spare_catalog, :boolean, default: false, null: false
  end
end
