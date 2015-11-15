class AddHstoreToSpareInfo < ActiveRecord::Migration
  def change
    enable_extension('hstore')
    add_column :spare_infos, :hstore, :hstore
  end
end
