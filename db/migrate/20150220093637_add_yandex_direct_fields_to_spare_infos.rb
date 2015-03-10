class AddYandexDirectFieldsToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :yandex_campaign_id, :integer
    add_column :spare_infos, :yandex_banner_id, :integer
  end
end
