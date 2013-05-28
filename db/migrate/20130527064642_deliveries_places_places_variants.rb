#class DeliveriesPlacesPlacesVariants < ActiveRecord::Migration
#  def change
#    create_table :deliveries_places_places_variants, id: false do |t|
#      t.references :place, index: true
#      t.references :variant, index: true
#
#      t.timestamps
#    end
#
#    #add_index :deliveries_places_places_variants, [:deliveries_places_place_id, :deliveries_places_variant_id], unique: true, name: 'index'
#  end
#end
