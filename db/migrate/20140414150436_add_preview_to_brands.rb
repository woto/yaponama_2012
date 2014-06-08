class AddPreviewToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :preview, :text
  end
end
