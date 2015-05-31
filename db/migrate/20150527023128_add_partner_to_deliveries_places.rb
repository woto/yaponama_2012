class AddPartnerToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :partner, :boolean, default: false, null: false
  end
end
