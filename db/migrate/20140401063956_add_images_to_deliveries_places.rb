class AddImagesToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :image1, :string
    add_column :deliveries_places, :image2, :string
    add_column :deliveries_places, :image3, :string
  end
end
