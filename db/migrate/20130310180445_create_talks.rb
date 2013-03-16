class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.references :talkable, polymorphic: true, index: true
      t.references :user, index: true
      t.references :creator, index: true
      t.boolean :read

      t.timestamps
    end
  end
end
