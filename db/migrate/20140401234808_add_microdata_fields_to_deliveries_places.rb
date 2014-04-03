class AddMicrodataFieldsToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :address_locality, :string
    add_column :deliveries_places, :postal_code, :string
    add_column :deliveries_places, :street_address, :string
    add_column :deliveries_places, :email1, :string
    add_column :deliveries_places, :email2, :string
    add_column :deliveries_places, :email3, :string
  end
end
