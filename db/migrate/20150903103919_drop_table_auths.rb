class DropTableAuths < ActiveRecord::Migration
  def change
    drop_table :auths
  end
end
