class RemoveSoundFromSomebodyTransactions < ActiveRecord::Migration
  def change
    remove_column :somebody_transactions, :sound_before, :boolean
    remove_column :somebody_transactions, :sound_after, :boolean
  end
end
