class RemoveOrderCostFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :order_cost
  end

  def down
  end
end
