class CreateGenerations < ActiveRecord::Migration
  def change
    create_table :generations do |t|
      t.string :name
      t.integer :model_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
