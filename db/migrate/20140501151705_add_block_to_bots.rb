class AddBlockToBots < ActiveRecord::Migration
  def change
    add_column :bots, :block, :boolean, default: false
  end
end
