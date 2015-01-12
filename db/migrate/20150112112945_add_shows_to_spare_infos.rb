class AddShowsToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :shows, :integer
  end
end
