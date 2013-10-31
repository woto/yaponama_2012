class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.references :talkable, polymorphic: true, index: true
      t.boolean :read

      t.timestamps
    end
  end
end
