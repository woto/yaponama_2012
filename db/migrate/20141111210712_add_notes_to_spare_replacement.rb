class AddNotesToSpareReplacement < ActiveRecord::Migration
  def change
    add_column :spare_replacements, :notes, :text
    add_column :spare_replacements, :notes_invisible, :text
  end
end
