class AddAttentionToNews < ActiveRecord::Migration
  def change
    add_column :news, :attention, :boolean
  end
end
