class CreateAdminMetro < ActiveRecord::Migration
  def change
    create_table :metro do |t|
      t.string :metro
      t.integer :delivery_cost

      t.timestamps
    end
  end
end
