class RemoveNameFromSpareInfo < ActiveRecord::Migration
  def change
    remove_column :spare_infos, :name, :string
  end
end
