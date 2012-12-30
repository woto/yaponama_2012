class CreatePagesUploads < ActiveRecord::Migration
  def up
    create_table :pages_uploads, :id => false do |t|
      t.integer :page_id
      t.integer :upload_id
    end
  end

  def down
    drop_table :pages_uploads
  end
end
