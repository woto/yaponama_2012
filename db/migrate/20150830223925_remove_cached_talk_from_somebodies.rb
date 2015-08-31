class RemoveCachedTalkFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :cached_talk, :string
  end
end
