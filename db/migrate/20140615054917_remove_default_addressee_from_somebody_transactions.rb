class RemoveDefaultAddresseeFromSomebodyTransactions < ActiveRecord::Migration
  def change
    remove_column :somebody_transactions, :default_addressee_id_before
    remove_column :somebody_transactions, :default_addressee_id_after
  end
end
