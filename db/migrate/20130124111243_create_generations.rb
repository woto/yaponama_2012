class CreateGenerations < ActiveRecord::Migration
  def change
    create_table :generations do |t|
      t.string :name
      t.text :content
      t.references :model, index: true
      t.string :cached_model
      t.references :creator, index: true
      t.boolean :phantom

      t.timestamps
    end
  end
end
