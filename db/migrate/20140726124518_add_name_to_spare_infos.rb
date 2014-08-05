class AddNameToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :name, :string
  end
end
