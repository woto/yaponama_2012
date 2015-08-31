class RemoveTotalTalksAndUnreadTalksFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :total_talks, :string
    remove_column :somebodies, :unread_talks, :string
  end
end
