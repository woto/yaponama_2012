class CreatePostalAddresses < ActiveRecord::Migration
  def change
    create_table :postal_addresses do |t|
      t.string :postcode
      t.string :region
      t.string :city
      t.string :street
      t.string :house
      t.boolean :stand_alone_house
      t.string :room
      t.timestamps
    end

  end
end
