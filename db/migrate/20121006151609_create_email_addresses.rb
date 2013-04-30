class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.string :email_address
      t.references :profile, index: true

      t.timestamps
    end

  end
end
