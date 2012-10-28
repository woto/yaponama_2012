class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :catalog_number
      t.string :manufacturer
      t.integer :quantity_ordered
      t.integer :quantity_available
      t.integer :probability
      t.integer :min_days
      t.integer :max_days
      t.string :status
      t.text :notes
      t.string :invisible
      t.integer :money
      t.references :user
      t.references :order

      t.timestamps
    end
    add_index :products, :user_id
    add_index :products, :order_id
  end
end
