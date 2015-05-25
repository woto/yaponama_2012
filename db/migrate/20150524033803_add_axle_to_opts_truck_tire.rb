class AddAxleToOptsTruckTire < ActiveRecord::Migration
  def change
    add_column :opts_truck_tires, :axle, :integer
  end
end
