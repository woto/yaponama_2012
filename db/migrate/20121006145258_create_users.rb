class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :creator_id
      t.string :invisible
      t.string :creation_reason
      t.decimal :discount, :precision => 8, :scale => 2
      t.decimal :prepayment_percent, :precision => 8, :scale => 2
      t.string :role
      t.string :auth_token
      t.string :password_digest
      t.string :password_reset_email_token
      t.string :password_reset_sms_token
      t.datetime :password_reset_sent_at

      # GEO
      t.string :ipgeobase_city
      t.string :ipgeobase_country
      t.string :ipgeobase_region
      t.string :ipgeobase_district
      t.float :ipgeobase_lat
      t.float :ipgeobase_lng

      # REQUEST
      t.string :accept_language
      t.string :user_agent
      t.integer :russian_time_zone_auto_id
      # ----------------------------------
      t.integer :russian_time_zone_manual_id
      t.inet :remote_ip

      t.timestamps
    end
  end
end
