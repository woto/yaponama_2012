class CreateTalkablesChatPartablesFiles < ActiveRecord::Migration
  def change
    create_table :talkables_chat_partables_files do |t|
      t.string :file
      t.string :title


      t.timestamps
    end
  end
end
