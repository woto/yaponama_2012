class CreateProductTransactions < ActiveRecord::Migration
  def change
    create_table :product_transactions do |t|
      t.string :log_catalog_number
      t.boolean :log_hide_catalog_number
      t.string :log_manufacturer
      t.string :log_status
      t.text :log_notes
      t.text :log_notes_invisible
      t.integer :log_user_id
      t.integer :log_creator_id
      t.integer :log_order_id
      t.datetime :log_created_at
      t.datetime :log_updated_at
      t.integer :log_supplier_id
      t.integer :log_quantity_ordered
      t.integer :log_quantity_available
      t.integer :log_probability
      t.integer :log_min_days
      t.integer :log_max_days
      t.decimal :log_buy_cost,           :precision => 8, :scale => 2
      t.decimal :log_sell_cost,           :precision => 8, :scale => 2
      t.string :log_short_name
      t.text :log_long_name
      t.integer :log_product_id
      t.integer :product_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
