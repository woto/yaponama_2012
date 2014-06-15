class RemoveAddresseeFromTalks < ActiveRecord::Migration
  def change
    remove_column :talks, :addressee_id, :integer
  end
end
