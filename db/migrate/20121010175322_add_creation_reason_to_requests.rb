class AddCreationReasonToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :creation_reason, :string
  end
end
