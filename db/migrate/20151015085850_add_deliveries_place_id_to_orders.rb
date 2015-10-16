class AddDeliveriesPlaceIdToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :deliveries_place, index: true, foreign_key: true
    Order.where.not(delivery_variant_id: -1).update_all("deliveries_place_id = delivery_variant_id")
    Order.where(delivery_variant_id: -1).update_all(delivery_variant_id: nil)
    Order.where(deliveries_place_id: nil, postal_address_id: nil).delete_all
  end
end
