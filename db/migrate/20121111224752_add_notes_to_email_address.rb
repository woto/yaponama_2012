class AddNotesToEmailAddress < ActiveRecord::Migration
  def change
    add_column :email_addresses, :notes, :text
  end
end
