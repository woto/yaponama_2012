class DropTalkablesChatPartablesTitlesTable < ActiveRecord::Migration
  def up
    drop_table :talkables_chat_partables_titles
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
