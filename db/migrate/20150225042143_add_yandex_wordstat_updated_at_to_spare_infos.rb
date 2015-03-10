class AddYandexWordstatUpdatedAtToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :yandex_wordstat_updated_at, :datetime
  end
end
