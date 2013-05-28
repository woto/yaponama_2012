class CreateDeliveriesPlacesVariants < ActiveRecord::Migration
  def change
    create_table :deliveries_places_variants do |t|
      t.references :place
      t.boolean :available
      t.integer :sequence
      t.string :name
      t.float :delivery_cost
      t.text :content

      t.timestamps
    end
  end
end
