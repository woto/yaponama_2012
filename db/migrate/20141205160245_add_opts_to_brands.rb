class AddOptsToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :opts, :string, :array => true, default: []
  end
end
