class AddEmailEmailAddressReferenceToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :email_address_id, :integer
  end
end
