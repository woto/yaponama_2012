class AddApproxCostAndDaysToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :approx_cost, :integer
    add_column :requests, :approx_days, :integer
  end
end
