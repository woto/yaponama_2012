class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :upload
      t.string :content_type
      t.integer :file_size
      t.integer :user_id

      t.timestamps
    end
  end
end
