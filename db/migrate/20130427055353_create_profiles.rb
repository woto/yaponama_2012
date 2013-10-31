class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :cached_names
      t.text :cached_phones
      t.text :cached_emails
      t.text :cached_passports

      t.timestamps
    end
  end
end
