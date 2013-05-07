class CreateAdminMetro < ActiveRecord::Migration
  def change
    create_table :metro do |t|
      t.string :metro
      t.integer :delivery_cost
      t.references :delivery, index: true

      t.timestamps
    end
  end
end
