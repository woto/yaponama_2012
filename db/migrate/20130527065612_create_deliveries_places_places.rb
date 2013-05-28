class CreateDeliveriesPlacesPlaces < ActiveRecord::Migration
  def change
    create_table :deliveries_places_places do |t|
      t.string :name
      t.text :content
      t.text :vertices
      t.boolean :postal_address_required

      ['active', 'inactive'].each do |style|
        t.string "#{style}_fill_color".to_sym
        t.string "#{style}_fill_opacity".to_sym
        t.string "#{style}_stroke_color".to_sym
        t.string "#{style}_stroke_opacity".to_sym
        t.string "#{style}_stroke_weight".to_sym
      end

      t.boolean :realize
      t.boolean :active
      t.float :lat
      t.float :lng
      t.integer :zoom

      t.integer :z_index
      t.boolean :display_marker

      t.timestamps
    end
  end
end
