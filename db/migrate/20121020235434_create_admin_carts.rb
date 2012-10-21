class CreateAdminCarts < ActiveRecord::Migration
  def change
    create_table :admin_carts do |t|
      t.string :catalog_number
      t.string :manufacturer
      t.integer :quantity
      t.integer :probability
      t.integer :min_days
      t.integer :max_days
      t.references :user

      t.timestamps
    end
    add_index :admin_carts, :user_id
  end
end
