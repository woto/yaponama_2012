class CreateSpareCatalogTokens < ActiveRecord::Migration
  def change
    create_table :spare_catalog_tokens do |t|
      t.references :spare_catalog, index: true
      t.string :name

      t.timestamps null: false
    end

    reversible do |dir|
      dir.up do
        SpareCatalog.all.each do |sc|
          sc.name.scan(/[[:word:]]+/).select{|word| word.length >= 3 }.each do |token|
            sc.spare_catalog_tokens.create(name: token)
          end
        end
      end
    end

  end
end
