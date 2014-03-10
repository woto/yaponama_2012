class AddManufacturerTransationsToBrandTransaction < ActiveRecord::Migration
  def change
    add_column :brand_transactions, :manufacturer_before, :boolean
    add_column :brand_transactions, :manufacturer_after, :boolean
  end
end
