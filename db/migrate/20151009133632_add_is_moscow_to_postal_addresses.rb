class AddIsMoscowToPostalAddresses < ActiveRecord::Migration
  def change
    add_column :postal_addresses, :is_moscow, :boolean
  end
end
