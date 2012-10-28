class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :name_id
      t.integer :postal_address_id
      t.integer :user_id
      t.integer :money
      t.timestamps
    end
  end
end
