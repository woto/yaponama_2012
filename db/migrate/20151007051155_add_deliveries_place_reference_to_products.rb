class AddDeliveriesPlaceReferenceToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :deliveries_place, index: true, foreign_key: true
  end
end
