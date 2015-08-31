class RemoveAnotherOldTables < ActiveRecord::Migration
  def change
    drop_table :blocks
    drop_table :block_transactions
    drop_table :pages
    drop_table :page_transactions
  end
end
