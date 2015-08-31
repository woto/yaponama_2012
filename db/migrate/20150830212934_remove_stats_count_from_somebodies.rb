class RemoveStatsCountFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :stats_count, :string
  end
end
