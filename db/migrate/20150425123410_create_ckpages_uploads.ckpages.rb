# This migration comes from ckpages (originally 20150425115824)
class CreateCkpagesUploads < ActiveRecord::Migration
  def change
    create_table :ckpages_uploads do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
