class CreateDeliveriesPlaces < ActiveRecord::Migration
  def change
    create_table :deliveries_places do |t|
      t.string :name
      t.text :content
      t.text :vertices

      ['active', 'inactive'].each do |style|
        t.string "#{style}_fill_color".to_sym
        t.string "#{style}_fill_opacity".to_sym
        t.string "#{style}_stroke_color".to_sym
        t.string "#{style}_stroke_opacity".to_sym
        t.string "#{style}_stroke_weight".to_sym
      end

      t.boolean :realize, default: true
      t.boolean :active, default: true
      t.float :lat
      t.float :lng
      t.integer :zoom

      t.integer :z_index
      t.boolean :display_marker

      t.timestamps
    end
  end
end