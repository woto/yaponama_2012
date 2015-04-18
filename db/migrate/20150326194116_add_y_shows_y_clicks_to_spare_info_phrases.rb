class AddYShowsYClicksToSpareInfoPhrases < ActiveRecord::Migration
  def change
    add_column :spare_info_phrases, :yclicks, :integer
    add_column :spare_info_phrases, :yshows, :integer
  end
end
