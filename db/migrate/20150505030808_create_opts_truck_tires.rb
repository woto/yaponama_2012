class CreateOptsTruckTires < ActiveRecord::Migration
  def change
    create_table :opts_truck_tires do |t|
      t.integer :height
      t.integer :width
      t.integer :diameter
      t.references :spare_info, index: true

      t.timestamps null: false
    end
  end
end
