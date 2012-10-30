class AddPrepaymentPercentToUser < ActiveRecord::Migration
  def change
    add_column :users, :prepayment_percent, :integer
  end
end
