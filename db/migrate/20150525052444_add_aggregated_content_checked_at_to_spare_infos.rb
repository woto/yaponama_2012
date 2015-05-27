class AddAggregatedContentCheckedAtToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :aggregated_content_checked_at, :datetime
  end
end
