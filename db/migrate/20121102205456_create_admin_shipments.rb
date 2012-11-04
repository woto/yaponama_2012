class CreateAdminShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :delivery_cost
      t.text :notes
      t.text :invisible

      t.timestamps
    end
  end
end
