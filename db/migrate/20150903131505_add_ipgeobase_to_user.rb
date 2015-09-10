class AddIpgeobaseToUser < ActiveRecord::Migration
  def change
    add_column :users, :ipgeobase_name, :string
    add_column :users, :ipgeobase_names_depth_cache, :string
  end
end
