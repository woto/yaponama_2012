class AddCachedFieldsToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :catalog_numbers, :string, array: true, default: []
    add_column :spare_infos, :titles, :text, array: true, default: []
    add_column :spare_infos, :min_days, :integer
    add_column :spare_infos, :min_cost, :integer
  end
end
