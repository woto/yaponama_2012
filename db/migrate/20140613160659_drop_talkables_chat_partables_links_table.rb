class DropTalkablesChatPartablesLinksTable < ActiveRecord::Migration
  def up
    drop_table :talkables_chat_partables_links
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
