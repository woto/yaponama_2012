class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.references :talkable, polymorphic: true, index: true
      t.boolean :read, default: false
      t.boolean :received, default: false
      t.references :addressee
      t.text :cached_talk


      t.timestamps
    end
  end
end
