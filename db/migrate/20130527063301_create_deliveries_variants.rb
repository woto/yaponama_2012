class CreateDeliveriesVariants < ActiveRecord::Migration
  def change
    create_table :deliveries_variants do |t|
      t.references :place
      t.references :option
      t.boolean :active
      t.integer :sequence
      t.string :name
      t.float :delivery_cost
      t.text :content

      t.timestamps
    end
  end
end
