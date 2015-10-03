class AddFaqIdToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :faq_id, :integer
  end
end
