class CreateOrderDeliveries < ActiveRecord::Migration
  def change
    create_table :order_deliveries do |t|
      t.references :creator, index: true
      t.references :somebody, index: true
      t.references :postal_address, index: true

      t.timestamps
    end
  end
end
