class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :postal_address, index: true
      t.references :metro, index: true
      t.references :shop, index: true
      t.references :company, index: true
      t.decimal :delivery_cost, :precision => 8, :scale => 2, default: 0
      t.string  :status, default: 'open'
      t.references :delivery, index: true
      t.references :profile, index: true
      t.string :token, index: true
      t.timestamps
    end
  end
end
