class CreateSpareInfoPhrases < ActiveRecord::Migration
  def change
    create_table :spare_info_phrases do |t|
      t.belongs_to :spare_info, index: true
      t.string :name
      t.integer :yandex_campaign_id
      t.integer :yandex_banner_id
      t.datetime :yandex_banner_updated_at
      t.datetime :yandex_wordstat_updated_at
      t.integer :yandex_shows

      t.timestamps null: false
    end
    add_foreign_key :spare_info_phrases, :spare_infos
  end
end
