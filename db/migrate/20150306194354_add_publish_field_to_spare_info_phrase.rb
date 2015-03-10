class AddPublishFieldToSpareInfoPhrase < ActiveRecord::Migration
  def change
    add_column :spare_info_phrases, :publish, :boolean
  end
end
