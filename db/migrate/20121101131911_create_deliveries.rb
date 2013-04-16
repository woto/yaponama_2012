class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.text :notes
      t.text :notes_invisible
      t.boolean :available, :default => true

      t.integer :delivery_category_id

      t.boolean :name_required, :default => false
      t.boolean :postal_address_required, :default => false
      t.boolean :full_prepayment_required, :default => false
      t.boolean :delivery_cost_required, :default => false
      t.boolean :phone_required, :default => false
      t.boolean :metro_required, :default => false
      t.boolean :shop_required, :default => false
      t.integer :sequence

      t.string :image

      t.timestamps
    end
  end
end
