class CreateDeliveriesOptions < ActiveRecord::Migration
  def change
    create_table :deliveries_options do |t|
      t.string :name
      t.boolean :full_prepayment_required
      t.boolean :postal_address_required
      t.boolean :passport_required

      t.timestamps
    end
  end
end
