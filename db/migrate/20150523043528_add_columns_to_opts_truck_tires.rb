class AddColumnsToOptsTruckTires < ActiveRecord::Migration
  def change
    add_column :opts_truck_tires, :load, :integer
    add_column :opts_truck_tires, :speed, :integer
    add_column :opts_truck_tires, :line, :integer
  end
end
