class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :catalog_number
      t.string :manufacturer
      t.string :status
      t.text :notes
      t.string :invisible
      t.references :user
      t.references :order

      t.timestamps
    end
    add_index :products, :user_id
    add_index :products, :order_id
  end
end
