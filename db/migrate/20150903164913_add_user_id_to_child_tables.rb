class AddUserIdToChildTables < ActiveRecord::Migration
  def change
    add_column :postal_addresses, :user_id, :integer
    add_index :postal_addresses, :user_id

    add_column :cars, :user_id, :integer
    add_index :cars, :user_id

    add_column :orders, :user_id, :integer
    add_index :orders, :user_id

    add_column :products, :user_id, :integer
    add_index :products, :user_id
  end
end
