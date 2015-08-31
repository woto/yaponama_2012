class RemoveSomeFieldsFromBots < ActiveRecord::Migration
  def change
    remove_column :bots, :creator_id, :string
    remove_column :bots, :phantom, :string
    remove_column :bots, :comment, :string
  end
end
