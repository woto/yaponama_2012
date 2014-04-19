class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.text :content
      t.string :image
      t.references :creator
      t.boolean :phantom, default: false

      t.timestamps
    end
  end
end
