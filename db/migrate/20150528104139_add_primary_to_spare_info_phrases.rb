class AddPrimaryToSpareInfoPhrases < ActiveRecord::Migration
  def change
    add_column :spare_info_phrases, :primary, :boolean

    reversible do |dir|
      dir.up do
        SpareInfoPhrase.reset_column_information
        SpareInfo.find_each do |si|
          begin
            if si.spare_info_phrases.exists?
              si.spare_info_phrases.first.update(primary: true)
            else
              si.create_spare_info_phrase(catalog_number: si.catalog_number)
            end
          rescue Exception => e
            puts si.catalog_number
            #binding.pry
          end
        end
      end
    end
  end

end
