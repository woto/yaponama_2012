class DropTablePoll < ActiveRecord::Migration
  def change
    drop_table :polls
  end
end
