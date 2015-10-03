class CreateDeliveriesPlaces < ActiveRecord::Migration
  def change
    create_table :deliveries_places do |t|
      t.string :name
      t.text :vertices
      t.boolean :realize, default: true
      t.boolean :active, default: true
      t.integer :z_index
      t.boolean :display_marker

      t.timestamps
    end
  end
end
