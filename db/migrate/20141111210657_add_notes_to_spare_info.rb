class AddNotesToSpareInfo < ActiveRecord::Migration
  def change
    add_column :spare_infos, :notes, :text
    add_column :spare_infos, :notes_invisible, :text
  end
end
