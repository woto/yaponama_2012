class CreateTalkablesChats < ActiveRecord::Migration
  def change
    create_table :talkables_chats do |t|

      t.timestamps
    end
  end
end
