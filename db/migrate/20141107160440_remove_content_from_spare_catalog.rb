class RemoveContentFromSpareCatalog < ActiveRecord::Migration
  def change
    remove_column :spare_catalogs, :content, :string
  end
end
