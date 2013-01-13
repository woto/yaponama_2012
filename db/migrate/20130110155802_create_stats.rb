class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :geo_city
      t.string :geo_country
      t.string :geo_region
      t.string :geo_district
      t.float :geo_lat
      t.float :geo_lng
      t.string :req_remote_addr
      t.string :req_ip
      t.string :req_remote_ip
      t.string :req_user_agent
      t.string :req_referrer
      t.string :req_referer
      t.string :req_accepts
      t.string :req_accept
      t.string :req_path
      t.string :req_base_url
      t.string :req_scheme
      t.string :req_request_method
      t.string :req_original_fullpath
      t.string :req_fullpath
      t.string :req_original_url
      t.string :req_url
      t.string :brs_time
      t.references :user

      t.timestamps
    end
    add_index :stats, :user_id
  end
end
