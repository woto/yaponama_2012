class AddRequiredAttributesToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :name_required, :boolean
    add_column :deliveries, :postal_address_required, :boolean
    add_column :deliveries, :full_prepayment_required, :boolean
    add_column :deliveries, :delivery_cost_required, :boolean
    add_column :deliveries, :sequence, :integer
  end
end
