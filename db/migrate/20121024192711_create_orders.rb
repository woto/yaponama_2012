class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :name, index: true
      t.references :postal_address, index: true
      t.references :metro, index: true
      t.references :shop, index: true
      t.decimal :delivery_cost, :precision => 8, :scale => 2
      t.string  :status
      t.references :delivery, index: true
      t.references  :phone, index: true
      t.timestamps
    end
  end
end
