class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :catalog_number
      t.boolean :hide_catalog_number
      t.string :manufacturer
      t.string :status
      t.references :order

      t.timestamps
    end
    add_index :products, :order_id
  end
end
