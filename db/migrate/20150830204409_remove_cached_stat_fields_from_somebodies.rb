class RemoveCachedStatFieldsFromSomebodies < ActiveRecord::Migration
  def change
    rename_column :somebodies, :cached_location, :location
    rename_column :somebodies, :cached_referrer, :referrer
    remove_column :somebodies, :cached_title, :string
    remove_column :somebodies, :cached_client_width, :string
    remove_column :somebodies, :cached_client_height, :string
    remove_column :somebodies, :cached_screen_width, :string
    remove_column :somebodies, :cached_screen_height, :string
    remove_column :somebodies, :cached_russian_time_zone_auto_id, :string
    remove_column :somebodies, :bot, :boolean
  end
end
