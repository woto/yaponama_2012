class AddRequstIdToCars < ActiveRecord::Migration
  def change
    add_column :cars, :request_id, :integer
  end
end
