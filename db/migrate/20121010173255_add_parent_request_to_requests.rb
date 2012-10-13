class AddParentRequestToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :parent_request, :integer
    add_column :requests, :type, :string
  end
end
