class CreateTalkablesChatParts < ActiveRecord::Migration
  def change
    create_table :talkables_chat_parts do |t|
      t.references :chat, index: true
      t.references :chat_partable, polymorphic: true, index: { name: 'talkables_chat_parts_on_chat_partable_id_and_chat_partable_type' }
      t.integer :order

      t.timestamps
    end
  end
end
