class RemoveSomeFieldsFromBots < ActiveRecord::Migration
  def change
    remove_column :bots, :comment, :string
  end
end
