class AddUrlFieldsToPageTransactions < ActiveRecord::Migration
  def change
    add_column :page_transactions, :url_before, :string
    add_column :page_transactions, :url_after, :string
  end
end
