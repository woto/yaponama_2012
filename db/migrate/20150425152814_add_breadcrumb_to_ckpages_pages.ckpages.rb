# This migration comes from ckpages (originally 20150425152740)
class AddBreadcrumbToCkpagesPages < ActiveRecord::Migration
  def change
    add_column :ckpages_pages, :title1, :text
    add_column :ckpages_pages, :url1, :text
    add_column :ckpages_pages, :title2, :text
    add_column :ckpages_pages, :url2, :text
    add_column :ckpages_pages, :title3, :text
    add_column :ckpages_pages, :url3, :text
    add_column :ckpages_pages, :title4, :text
    add_column :ckpages_pages, :url4, :text
    add_column :ckpages_pages, :title5, :text
    add_column :ckpages_pages, :url5, :text
  end
end
