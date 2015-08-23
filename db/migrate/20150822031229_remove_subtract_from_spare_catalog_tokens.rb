class RemoveSubtractFromSpareCatalogTokens < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up {
        SpareCatalogToken.where.not(subtract: nil).each do |sct|
          sct.spare_catalog.spare_catalog_tokens.create!(
            name: sct.subtract,
            weight: -100
          )
        end
      }
    end
    remove_column :spare_catalog_tokens, :subtract, :string
  end
end
