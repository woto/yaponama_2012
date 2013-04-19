class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :catalog_number
      t.string :manufacturer
      t.string :short_name
      t.text :long_name
      t.integer :quantity_ordered
      t.integer :quantity_available
      t.integer :min_days
      t.integer :max_days
      t.decimal :buy_cost, :precision => 8, :scale => 2
      t.decimal :sell_cost, :precision => 8, :scale => 2
      t.boolean :hide_catalog_number, :default => false
      t.string :status
      t.integer :probability

      t.references :product
      t.references :order
      t.references :supplier

      t.timestamps
    end
    add_index :products, :order_id
    add_index :products, :product_id
    add_index :products, :supplier_id
  end
end
