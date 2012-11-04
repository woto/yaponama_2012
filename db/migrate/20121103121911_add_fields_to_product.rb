class AddFieldsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :quantity_ordered, :integer
    add_column :products, :quantity_available, :integer
    add_column :products, :probability, :integer
    add_column :products, :min_days, :integer
    add_column :products, :max_days, :integer
    add_column :products, :cost_buy, :integer
    add_column :products, :cost_sell, :integer
  end
end
