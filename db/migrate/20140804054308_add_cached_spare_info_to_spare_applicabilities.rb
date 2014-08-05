class AddCachedSpareInfoToSpareApplicabilities < ActiveRecord::Migration
  def change
    add_column :spare_applicabilities, :cached_spare_info, :string
  end
end
