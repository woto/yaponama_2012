class AddDefaultDisplayToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :default_display, :boolean
  end
end
