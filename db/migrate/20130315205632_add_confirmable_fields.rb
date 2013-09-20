class AddConfirmableFields < ActiveRecord::Migration
  def change
    ['emails', 'phones'].each do |table|
      add_column table, :confirmed, :boolean, :default => false
      add_column table, :confirmation_datetime, :datetime
      add_column table, :confirmation_token, :string
    end
  end
end
