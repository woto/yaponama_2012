class AddOffersToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :offers, :integer
  end
end
