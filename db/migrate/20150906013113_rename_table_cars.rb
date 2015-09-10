class RenameTableCars < ActiveRecord::Migration
  def change
    rename_table :cars, :user_cars
  end
end
