class AddCostAndDaysToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :cost, :integer
    add_column :requests, :days, :integer
  end
end
