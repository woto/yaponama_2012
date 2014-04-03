class AddPhonesToDeliveriesPlaces < ActiveRecord::Migration
  def change
    add_column :deliveries_places, :phone1, :string
    add_column :deliveries_places, :phone2, :string
    add_column :deliveries_places, :phone3, :string
    add_column :deliveries_places, :phone4, :string
    add_column :deliveries_places, :phone5, :string
  end
end
