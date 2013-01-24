class AddSellCarAttributesToCars < ActiveRecord::Migration
  def change
    add_column :cars, :selling, :boolean
    add_column :cars, :cost, :integer
    add_column :cars, :advertisement, :text
  end
end
