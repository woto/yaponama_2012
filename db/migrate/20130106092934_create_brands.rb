class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.references :brand, index: true
      t.string :image
      t.integer :rating
      t.text :content
      t.references :creator, index: true

      t.timestamps
    end
  end
end
