class AddYFieldsToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :ycountry, :string
    add_column :deliveries_places, :ycountry_code, :string
    add_column :deliveries_places, :ycity, :string
    add_column :deliveries_places, :ystreet, :string
    add_column :deliveries_places, :yhouse, :string
    add_column :deliveries_places, :ycity_code, :string
    add_column :deliveries_places, :yphone, :string
    add_column :deliveries_places, :ycompany_name, :string
    add_column :deliveries_places, :ycontact_email, :string
    add_column :deliveries_places, :ywork_time, :string
    add_column :deliveries_places, :yogrn, :string
  end
end
