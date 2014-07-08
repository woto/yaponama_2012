class CahgeDefaultValueForConfirmed < ActiveRecord::Migration
  def change
    change_column :phones, :confirmed, :boolean, :default => nil
    change_column :emails, :confirmed, :boolean, :default => nil
  end
end
