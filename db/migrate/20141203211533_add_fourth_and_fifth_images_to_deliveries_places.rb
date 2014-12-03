class AddFourthAndFifthImagesToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :image4, :string
    add_column :deliveries_places, :image5, :string
  end
end
