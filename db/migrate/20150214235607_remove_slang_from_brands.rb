class RemoveSlangFromBrands < ActiveRecord::Migration
  def change
    remove_column :brands, :slang, :string
  end
end
