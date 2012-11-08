class AddDeliveryCategoryToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivery_category_id, :integer
  end
end
