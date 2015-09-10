class RenameTablePostalAddresses < ActiveRecord::Migration
  def change
    rename_table :postal_addresses, :user_postal_addresses
  end
end
