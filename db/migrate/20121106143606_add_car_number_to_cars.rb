class AddCarNumberToCars < ActiveRecord::Migration
  def change
    add_column :cars, :car_number, :string
  end
end
