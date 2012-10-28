class AddDiscountToUser < ActiveRecord::Migration
  def change
    add_column :users, :discount, :integer
  end
end
