class AddPhoneIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :phone_id, :integer
  end
end
