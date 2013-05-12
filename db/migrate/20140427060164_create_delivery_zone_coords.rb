class CreateDeliveryZoneCoords < ActiveRecord::Migration
  def change
    create_table :delivery_zone_coords do |t|
      t.float :lat
      t.float :lng
      t.references :delivery_zone, index: true

      t.timestamps
    end
  end
end
