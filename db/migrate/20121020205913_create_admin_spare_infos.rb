class CreateAdminSpareInfos < ActiveRecord::Migration
  def change
    create_table :admin_spare_infos do |t|
      t.string :catalog_number
      t.string :manufacturer
      t.text :content

      t.timestamps
    end
  end
end
