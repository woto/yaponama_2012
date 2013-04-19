class CreateGenerations < ActiveRecord::Migration
  def change
    create_table :generations do |t|
      t.string :name
      t.references :model, index: true
      t.references :creator, index: true

      t.timestamps
    end
  end
end
