class RemoveChatFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :chat, :string
  end
end
