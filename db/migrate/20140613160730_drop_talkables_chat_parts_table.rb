class DropTalkablesChatPartsTable < ActiveRecord::Migration
  def up
    drop_table :talkables_chat_parts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
