class AddDefaultDisplayTransactionFieldsToBrandTransactions < ActiveRecord::Migration
  def change
    add_column :brand_transactions, :default_display_before, :boolean
    add_column :brand_transactions, :default_display_after, :boolean
  end
end
