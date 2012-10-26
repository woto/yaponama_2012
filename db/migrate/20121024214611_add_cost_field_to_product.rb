class AddCostFieldToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cost, :integer
  end
end
