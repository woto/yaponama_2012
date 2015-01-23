class AddPreviewToGenerations < ActiveRecord::Migration
  def change
    add_column :generations, :preview, :text
  end
end
