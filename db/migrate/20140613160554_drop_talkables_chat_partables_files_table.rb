class DropTalkablesChatPartablesFilesTable < ActiveRecord::Migration
  def up
    drop_table :talkables_chat_partables_files
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
