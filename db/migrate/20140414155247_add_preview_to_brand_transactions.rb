class AddPreviewToBrandTransactions < ActiveRecord::Migration
  def change
    add_column :brand_transactions, :preview_before, :text
    add_column :brand_transactions, :preview_after, :text
  end
end
