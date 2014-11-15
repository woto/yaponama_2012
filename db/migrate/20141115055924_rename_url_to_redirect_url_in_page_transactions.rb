class RenameUrlToRedirectUrlInPageTransactions < ActiveRecord::Migration
  def change
    change_table :page_transactions do |t|
      t.rename :url_before, :redirect_url_before
      t.rename :url_after, :redirect_url_after
    end
  end
end
