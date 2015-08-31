class AddBotsIndexesToSomebodies < ActiveRecord::Migration
  def change
    add_index :somebodies, :user_agent
    add_index :somebodies, :remote_ip
  end
end
