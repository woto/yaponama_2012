class AddConfirmableFields < ActiveRecord::Migration
  def change
    ['email_addresses', 'phones'].each do |table|
      add_column table, :confirmed_by_user, :boolean
      add_column table, :confirmed_by_manager, :boolean 
      add_column table, :user_confirmation_datetime, :datetime 
      add_column table, :manager_confirmation_datetime, :datetime
      add_column table, :confirmation_token, :string
    end
  end
end
