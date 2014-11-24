class AddImagesToSpareInfos < ActiveRecord::Migration
  def change
    add_column :spare_infos, :image1, :string
    add_column :spare_infos, :image2, :string
    add_column :spare_infos, :image3, :string
    add_column :spare_infos, :image4, :string
    add_column :spare_infos, :image5, :string
    add_column :spare_infos, :image6, :string
    add_column :spare_infos, :image7, :string
    add_column :spare_infos, :image8, :string
    add_column :spare_infos, :file1, :string
    add_column :spare_infos, :file2, :string
    add_column :spare_infos, :file3, :string
    add_column :spare_infos, :file4, :string
    add_column :spare_infos, :file5, :string
    add_column :spare_infos, :file6, :string
    add_column :spare_infos, :file7, :string
    add_column :spare_infos, :file8, :string
  end
end
