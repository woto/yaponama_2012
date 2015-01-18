class AddMetroToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :metro, :string
  end
end
