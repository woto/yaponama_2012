class RemoveCachedSpareInfoFromSpareApplicabilities < ActiveRecord::Migration
  def change
    remove_column :spare_applicabilities, :cached_spare_info, :string
  end
end
