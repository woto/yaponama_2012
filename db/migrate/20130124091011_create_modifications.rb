class CreateModifications < ActiveRecord::Migration
  def change
    create_table :modifications do |t|
      t.string :name
      t.text :content
      t.references :generation, index: true
      t.string :cached_generation
      t.references :creator, index: true
      t.boolean :phantom

      t.timestamps
    end
  end
end
