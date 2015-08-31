class AddLocationAndReferrerToSomebodyTransactions < ActiveRecord::Migration
  def change
    add_column :somebody_transactions, :location_before, :text
    add_column :somebody_transactions, :location_after, :text
    add_column :somebody_transactions, :referrer_before, :text
    add_column :somebody_transactions, :referrer_after, :text
  end
end
