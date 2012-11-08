class AddImageToDeliveryCategory < ActiveRecord::Migration
  def change
    add_column :delivery_categories, :image, :string
  end
end
