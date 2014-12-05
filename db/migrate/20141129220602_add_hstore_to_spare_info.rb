class AddHstoreToSpareInfo < ActiveRecord::Migration
  def change
    add_column :spare_infos, :hstore, :hstore
  end
end
