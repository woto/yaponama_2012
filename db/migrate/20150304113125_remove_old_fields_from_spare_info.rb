class RemoveOldFieldsFromSpareInfo < ActiveRecord::Migration
  def change
    remove_column :spare_infos, :yandex_campaign_id, :integer
    remove_column :spare_infos, :yandex_banner_id, :integer
    remove_column :spare_infos, :yandex_banner_updated_at, :datetime
    remove_column :spare_infos, :yandex_wordstat_updated_at, :datetime
    remove_column :spare_infos, :shows, :integer
  end
end
