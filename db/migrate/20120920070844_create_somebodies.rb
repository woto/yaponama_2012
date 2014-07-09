class CreateSomebodies < ActiveRecord::Migration
  def change
    create_table :somebodies do |t|
      t.decimal :discount, :precision => 8, :scale => 2
      t.decimal :prepayment, :precision => 8, :scale => 2
      t.string :role
      t.string :auth_token
      t.string :password_digest

      # PASSWORD RESET
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      #t.integer :password_reset_attempts
      # TODO Защититься

      # GEO
      t.string :ipgeobase_name
      t.string :ipgeobase_names_depth_cache

      # REQUEST
      t.string :accept_language
      t.string :user_agent
      t.integer :cached_russian_time_zone_auto_id
      # ----------------------------------
      t.inet :remote_ip

      t.string :creation_reason
      t.text :notes
      t.text :notes_invisible
      t.references :creator, index: true

      t.boolean :phantom, default: false

      t.boolean :logout_from_other_places, default: true

      t.boolean :online, default: false

      t.boolean :sound, default: true

      t.text :chat

      # Главный профиль
      t.references :profile
      t.text :cached_profile

      t.decimal :cached_debit, :default => 0, :precision => 8, :scale => 2
      t.decimal :cached_credit, :default => 0, :precision => 8, :scale => 2

      # rrda
      t.string :type

      t.string :order_rule

      t.integer :stats_count

      t.datetime :touch_confirm

      t.text :cached_location
      t.string :cached_title
      t.text :cached_referrer
      t.text :first_referrer
      t.string :cached_screen_width
      t.string :cached_screen_height
      t.string :cached_client_width
      t.string :cached_client_height

      t.string :cached_talk
      t.string :transport

      t.integer :unread_talks, default: 0
      t.integer :total_talks, default: 0

      t.references :default_addressee

      t.timestamps
    end
  end
end
