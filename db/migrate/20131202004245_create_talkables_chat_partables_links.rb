class CreateTalkablesChatPartablesLinks < ActiveRecord::Migration
  def change
    create_table :talkables_chat_partables_links do |t|
      t.string :url
      t.string :title
      t.string :target

      t.timestamps
    end
  end
end
