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
      t.integer :russian_time_zone_manual_id
      t.boolean :use_auto_russian_time_zone, :default => true
      t.inet :remote_ip

      t.string :creation_reason
      t.text :notes
      t.text :notes_invisible
      t.references :creator, index: true

      t.boolean :phantom # TODO Позже задействовать

      t.boolean :logout_from_other_places, default: true

      t.boolean :online

      t.boolean :sound, default: true

      t.text :chat

      # Место, где находится менеджер (может и не быть)
      t.references :place

      # Должность
      t.string :post
      
      # Главный профиль
      t.references :main_profile
      t.text :cached_main_profile

      t.decimal :cached_debit, :default => 0, :precision => 8, :scale => 2
      t.decimal :cached_credit, :default => 0, :precision => 8, :scale => 2

      # rrda
      t.string :type

      t.string :order_rule

      t.integer :stats_count

      t.datetime :touch_confirm

      t.string :cached_location
      t.string :cached_title
      t.string :cached_referrer
      t.string :first_referrer
      t.string :cached_screen_width
      t.string :cached_screen_height
      t.string :cached_client_width
      t.string :cached_client_height

      t.timestamps
    end
  end
end
