class AddTransactionFieldsToBrandTransactions < ActiveRecord::Migration
  def change
    add_column :brand_transactions, :slang_before, :string
    add_column :brand_transactions, :slang_after, :string
  end
end
