class DropTalkablesChatPartablesTextsTable < ActiveRecord::Migration
  def up
    drop_table :talkables_chat_partables_texts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
