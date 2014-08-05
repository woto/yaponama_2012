class CreateSpareApplicabilities < ActiveRecord::Migration
  def change
    create_table :spare_applicabilities do |t|
      t.references :spare_info, index: true
      t.references :brand, index: true
      t.references :model, index: true
      t.references :generation, index: true
      t.references :modification, index: true
      t.string :cached_brand
      t.string :cached_model
      t.string :cached_generation
      t.string :cached_modification

      t.timestamps
    end
  end
end
