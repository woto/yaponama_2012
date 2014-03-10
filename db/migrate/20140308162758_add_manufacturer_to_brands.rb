class AddManufacturerToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :manufacturer, :boolean
  end
end
