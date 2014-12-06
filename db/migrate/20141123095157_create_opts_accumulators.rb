class CreateOptsAccumulators < ActiveRecord::Migration
  def change
    create_table :opts_accumulators do |t|
      t.integer :voltage
      t.integer :battery_capacity
      t.integer :cold_cranking_amps
      t.integer :length
      t.integer :width
      t.integer :height
      t.string :base_hold_down
      t.string :layout
      t.string :terminal_types
      t.string :case_size
      t.float :weight_filled
      t.references :spare_info, index: true

      t.timestamps null: false
    end
  end
end
