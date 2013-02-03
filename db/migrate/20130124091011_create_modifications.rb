class CreateModifications < ActiveRecord::Migration
  def change
    create_table :modifications do |t|
      t.string :name
      t.integer :generation_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
