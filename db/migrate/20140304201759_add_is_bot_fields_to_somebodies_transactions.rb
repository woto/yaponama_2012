class AddIsBotFieldsToSomebodiesTransactions < ActiveRecord::Migration
  def change
    add_column :somebody_transactions, :bot_before, :boolean
    add_column :somebody_transactions, :bot_after, :boolean
  end
end
