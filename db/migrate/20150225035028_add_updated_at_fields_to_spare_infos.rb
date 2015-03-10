class AddUpdatedAtFieldsToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :aggregated_content_updated_at, :datetime
    add_column :spare_infos, :yandex_banner_updated_at, :datetime
  end
end
