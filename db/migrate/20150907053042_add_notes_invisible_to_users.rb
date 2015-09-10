class AddNotesInvisibleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notes_invisible, :text
  end
end
