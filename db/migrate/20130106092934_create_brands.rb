class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.integer :brand_id
      t.string :image
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
