class RemoveCachedSpareInfosFromSpareReplacements < ActiveRecord::Migration
  def change
    remove_column :spare_replacements, :from_cached_spare_info, :string
    remove_column :spare_replacements, :to_cached_spare_info, :string
  end
end
