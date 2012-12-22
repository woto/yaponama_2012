class AddUploadToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :upload, :string
  end
end
