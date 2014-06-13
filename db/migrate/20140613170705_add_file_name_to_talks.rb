class AddFileNameToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :file_name, :string
  end
end
