class AddSpareCatalogsToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :cached_spare_catalog, :string
    add_reference :spare_infos, :spare_catalog, index: true
  end
end
