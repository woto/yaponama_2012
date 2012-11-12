class AddNotesToName < ActiveRecord::Migration
  def change
    add_column :names, :notes, :text
  end
end
