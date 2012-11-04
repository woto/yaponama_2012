class ChangeFinancialTypesFromIntegerToDecimal < ActiveRecord::Migration
  def up
    change_column :accounts, :debit, :decimal, :precision => 8, :scale => 2
    change_column :accounts, :credit, :decimal, :precision => 8, :scale => 2
    change_column :products, :cost_buy, :decimal, :precision => 8, :scale => 2
    change_column :products, :cost_sell, :decimal, :precision => 8, :scale => 2
    change_column :shipments, :delivery_cost, :decimal, :precision => 8, :scale => 2
    change_column :users, :discount, :decimal, :precision => 8, :scale => 2
    change_column :users, :prepayment_percent, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
