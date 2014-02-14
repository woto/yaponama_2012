class CreateSpareCatalogs < ActiveRecord::Migration
  def change
    create_table :spare_catalogs do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
