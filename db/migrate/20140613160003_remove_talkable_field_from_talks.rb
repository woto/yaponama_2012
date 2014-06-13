class RemoveTalkableFieldFromTalks < ActiveRecord::Migration
  def change
    remove_reference :talks, :talkable, index: true, :polymorphic => true
  end
end
