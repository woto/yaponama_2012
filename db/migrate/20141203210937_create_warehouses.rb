class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.references :spare_info, index: true
      t.integer :count
      t.integer :price
      t.references :place, index: true

      t.timestamps null: false
    end
  end
end
