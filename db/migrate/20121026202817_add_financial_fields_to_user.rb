class AddFinancialFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :money_available, :integer
    add_column :users, :money_locked, :integer
    add_column :users, :discount, :integer
  end
end
