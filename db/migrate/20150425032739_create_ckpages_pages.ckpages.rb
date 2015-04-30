# This migration comes from ckpages (originally 20150424201308)
class CreateCkpagesPages < ActiveRecord::Migration
  def change
    create_table :ckpages_pages do |t|
      t.text :path
      t.text :content
      t.text :keywords
      t.text :description
      t.text :title
      t.text :robots
      t.text :redirect_url

      t.timestamps null: false
    end
  end
end
