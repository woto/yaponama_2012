class AddNameFieldToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :name, :string
  end
end
