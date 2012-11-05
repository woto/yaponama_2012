class AddFieldsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :quantity_ordered, :integer
    add_column :products, :quantity_available, :integer
    add_column :products, :probability, :integer
    add_column :products, :min_days, :integer
    add_column :products, :max_days, :integer
    add_column :products, :buy_cost, :decimal, :precision => 8, :scale => 2
    add_column :products, :sell_cost, :decimal, :precision => 8, :scale => 2
  end
end
