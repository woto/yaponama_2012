class CreateAdminOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :name_id
      t.integer :postal_address_id
      t.integer :user_id
      t.integer :product_id
      t.timestamps
    end
  end
end
