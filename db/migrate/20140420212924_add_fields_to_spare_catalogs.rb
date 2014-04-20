class AddFieldsToSpareCatalogs < ActiveRecord::Migration
  def change
    add_column :spare_catalogs, :intro, :text
    add_column :spare_catalogs, :page, :text
  end
end
