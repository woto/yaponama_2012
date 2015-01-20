class AddNewImageToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :new_image, :string
  end
end
