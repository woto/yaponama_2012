class CreateSpareInfos < ActiveRecord::Migration
  def change
    create_table :spare_infos do |t|
      t.string :catalog_number
      t.belongs_to :brand, index: true
      t.string :cached_brand
      t.text :content

      t.timestamps
    end
  end
end
