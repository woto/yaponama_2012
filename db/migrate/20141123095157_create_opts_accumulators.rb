class CreateOptsAccumulators < ActiveRecord::Migration
  def change
    create_table :opts_accumulators do |t|
      t.integer :voltage
      t.integer :battery_capacity
      t.integer :cold_cranking_amps
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :base_hold_down
      t.integer :layout
      t.integer :terminal_types
      t.integer :case_size
      t.integer :weight_filled
      t.references :spare_info, index: true
      t.references :creator, index: true

      t.timestamps null: false
    end
  end
end
