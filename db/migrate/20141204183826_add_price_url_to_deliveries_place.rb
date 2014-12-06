class AddPriceUrlToDeliveriesPlace < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :price_url, :string
  end
end
