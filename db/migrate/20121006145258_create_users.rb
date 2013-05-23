class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.decimal :discount, :precision => 8, :scale => 2
      t.decimal :prepayment, :precision => 8, :scale => 2
      t.string :role
      t.string :auth_token
      t.string :password_digest
      t.string :password_reset_email_token
      t.string :password_reset_sms_token
      t.datetime :password_reset_sent_at

      # GEO
      t.string :ipgeobase_name
      t.string :ipgeobase_names_depth_cache

      # REQUEST
      t.string :accept_language
      t.string :user_agent
      t.integer :russian_time_zone_auto_id
      # ----------------------------------
      t.integer :russian_time_zone_manual_id
      t.boolean :use_auto_russian_time_zone, :default => true
      t.inet :remote_ip

      t.string :creation_reason
      t.text :notes
      t.text :notes_invisible
      t.references :creator, index: true

      t.text :cached_profile # TODO пока text, позже переделать в string

      t.boolean :phantom # TODO Позже задействовать

      t.timestamps
    end
  end
end
