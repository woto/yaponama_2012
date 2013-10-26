class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :brand, index: true
      t.string :cached_brand
      t.string :name
      t.text :content
      t.references :creator, index: true
      t.boolean :phantom

      t.timestamps
    end
  end
end
