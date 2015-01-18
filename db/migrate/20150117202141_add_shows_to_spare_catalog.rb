class AddShowsToSpareCatalog < ActiveRecord::Migration
  def change
    add_column :spare_catalogs, :shows, :integer
  end
end
