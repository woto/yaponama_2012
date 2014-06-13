class AddTextAndFileFieldsToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :text, :text
    add_column :talks, :file, :string
  end
end
