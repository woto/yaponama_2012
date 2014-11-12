class AddNotesToSpareApplicability < ActiveRecord::Migration
  def change
    add_column :spare_applicabilities, :notes, :text
    add_column :spare_applicabilities, :notes_invisible, :text
  end
end
