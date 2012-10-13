class CreatePostalAddresses < ActiveRecord::Migration
  def change
    create_table :postal_addresses do |t|
      t.string :company
      t.string :postcode
      t.string :region
      t.string :city
      t.string :street
      t.string :house
      t.string :room
      t.text :notes
      t.string :invisible
      t.references :user

      t.timestamps
    end
    add_index :postal_addresses, :user_id
  end
end
