class AddNotesToCar < ActiveRecord::Migration
  def change
    add_column :cars, :notes, :text
  end
end
