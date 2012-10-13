class AddCheckNeededToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :check_needed, :string
  end
end
