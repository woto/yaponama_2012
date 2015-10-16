class AddEmailToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :email, :string
  end
end
