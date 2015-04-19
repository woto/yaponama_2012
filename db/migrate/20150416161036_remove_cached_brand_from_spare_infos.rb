class RemoveCachedBrandFromSpareInfos < ActiveRecord::Migration
  def change
    remove_column :spare_infos, :cached_brand, :string
  end
end
