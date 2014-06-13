class DropTalkablesChatsTable < ActiveRecord::Migration
  def up
    drop_table :talkables_chats
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
