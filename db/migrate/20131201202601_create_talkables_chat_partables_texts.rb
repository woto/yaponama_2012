class CreateTalkablesChatPartablesTexts < ActiveRecord::Migration
  def change
    create_table :talkables_chat_partables_texts do |t|
      t.text :text

      t.timestamps
    end
  end
end
