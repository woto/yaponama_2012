class AddMailToAdminSiteSetting < ActiveRecord::Migration
  def change
    add_column :admin_site_settings, :mail_delivery_method, :string
    add_column :admin_site_settings, :smtp_address, :string
    add_column :admin_site_settings, :smtp_port, :boolean
    add_column :admin_site_settings, :smtp_user_name, :string
    add_column :admin_site_settings, :smtp_password, :string
    add_column :admin_site_settings, :smtp_authentication, :string
    add_column :admin_site_settings, :smtp_enable_starttls_auto, :boolean
  end
end
