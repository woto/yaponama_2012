class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.text :notes
      t.boolean :available
      t.boolean :prepayment
      t.text :invisible

      t.timestamps
    end
  end
end
