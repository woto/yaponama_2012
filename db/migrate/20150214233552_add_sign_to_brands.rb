class AddSignToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :sign, :integer
  end
end
