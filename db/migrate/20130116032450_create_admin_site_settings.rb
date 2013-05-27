class CreateAdminSiteSettings < ActiveRecord::Migration
  def change
    create_table :admin_site_settings do |t|
      t.string :environment
      t.string :sms_notify_method
      t.boolean :send_request_from_search_page
      t.integer :price_request_cache_with_replacements_in_seconds
      t.integer :price_request_cache_without_replacements_in_seconds
      t.boolean :request_emex
      t.float :emex_income_rate
      t.float :avtorif_income_rate
      t.float :retail_rate
      t.string :robokassa_integration_mode
      t.string :robokassa_pass_1
      t.string :robokassa_pass_2
      t.string :robokassa_user

      t.string :google_maps_key
      t.string :travel_mode
      t.float :initial_map_lat
      t.float :initial_map_lng
      t.integer :initial_map_zoom
      t.float :delivery_minute_cost
      t.string :warehouse_address
      t.boolean :automatic_calculate_active
      t.float :max_automatic_calculated_cost

      t.string :checkout_account
      t.string :checkout_bank
      t.string :checkout_bik
      t.string :checkout_correspondent
      t.string :checkout_inn
      t.string :checkout_recipient

      t.text :counter_yandex
      t.text :counter_mail
      t.text :counter_rambler
      t.text :counter_google
      t.text :counter_openstat
      t.text :counter_liveinternet

      t.float :default_user_prepayment
      t.float :default_user_discount
      t.string :default_user_order_rule
      t.string :avisosms_username
      t.string :avisosms_password
      t.string :avisosms_source_address
      t.string :avisosms_delivery_report
      t.string :avisosms_flash_message
      t.string :avisosms_validity_period
      t.string :site_address
      t.string :site_port
      t.string :redis_address
      t.string :redis_port
      t.string :socket_io_address
      t.string :socket_io_port
      t.string :juggernaut_address
      t.string :juggernaut_port
      t.string :price_address
      t.string :price_port
      t.string :get_image_data_address
      t.string :get_image_data_port
      t.string :google_oauth2_key
      t.string :google_oauth2_secret
      t.string :facebook_key
      t.string :facebook_secret
      t.string :yandex_key
      t.string :yandex_secret
      t.string :twitter_key
      t.string :twitter_secret
      t.string :vkontakte_key
      t.string :vkontakte_secret
      t.string :odnoklassniki_key
      t.string :odnoklassniki_secret
      t.string :mailru_key
      t.string :mailru_secret

      t.timestamps
    end
  end
end
