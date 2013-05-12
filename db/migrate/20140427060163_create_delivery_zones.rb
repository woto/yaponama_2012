class CreateDeliveryZones < ActiveRecord::Migration
  def change
    create_table :delivery_zones do |t|
      t.string :name
      t.text :vertices

      t.timestamps
    end
  end
end
