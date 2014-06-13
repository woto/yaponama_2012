class DropTalkablesLetterTable < ActiveRecord::Migration
  def up
    drop_table :talkables_letters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
