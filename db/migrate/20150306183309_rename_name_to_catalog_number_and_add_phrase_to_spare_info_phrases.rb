class RenameNameToCatalogNumberAndAddPhraseToSpareInfoPhrases < ActiveRecord::Migration
  def change
    rename_column :spare_info_phrases, :name, :catalog_number
    add_column :spare_info_phrases, :phrase, :string
  end
end
