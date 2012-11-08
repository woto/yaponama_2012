class AddDeliveryIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_id, :integer
  end
end
