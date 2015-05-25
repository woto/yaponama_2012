class AddSubtractToSpareCatalogTokens < ActiveRecord::Migration
  def change
    add_column :spare_catalog_tokens, :subtract, :string
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE spare_catalog_tokens SET name = CONCAT('%', name, '%')
        SQL
      end
    end
  end
end
