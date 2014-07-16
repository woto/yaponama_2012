class RemoveOnlineFieldFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :online, :string
  end
end
