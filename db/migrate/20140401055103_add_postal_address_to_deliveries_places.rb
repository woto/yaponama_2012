class AddPostalAddressToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :postal_address, :string
  end
end
