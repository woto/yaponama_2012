class AddOptToSpareCatalog < ActiveRecord::Migration
  def change
    add_column :spare_catalogs, :opt, :string
  end
end
