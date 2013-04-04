class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :name_id
      t.integer :postal_address_id
      t.integer :metro_id
      t.integer :user_id
      t.integer :creator_id
      t.decimal :delivery_cost, :precision => 8, :scale => 2
      t.string  :status
      t.references :delivery
      t.string  :active
      t.references  :phone
      t.text :notes
      t.text :notes_invisible
      t.timestamps
    end
  end
end
