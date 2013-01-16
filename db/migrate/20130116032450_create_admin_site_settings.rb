class CreateAdminSiteSettings < ActiveRecord::Migration
  def change
    create_table :admin_site_settings do |t|
      t.string :environment
      t.boolean :request_emex
      t.float :emex_income_rate
      t.float :avtorif_income_rate
      t.float :retail_rate
      t.string :robokassa_integration_mode
      t.string :robokassa_pass_1
      t.string :robokassa_pass_2
      t.string :robokassa_user
      t.boolean :send_request_from_search_page
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

      t.timestamps
    end
  end
end
