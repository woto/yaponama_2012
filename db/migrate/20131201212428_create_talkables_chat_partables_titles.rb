class CreateTalkablesChatPartablesTitles < ActiveRecord::Migration
  def change
    create_table :talkables_chat_partables_titles do |t|
      t.string :title
      t.string :size

      t.timestamps
    end
  end
end
