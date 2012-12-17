class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.string :email_address
      t.boolean :confirmed_by_robot
      t.boolean :confirmed_by_human
      t.datetime :robot_confirmation_datetime
      t.datetime :human_confirmation_datetime
      t.string :invisible
      t.integer :user_id
      t.integer :creator_id

      t.timestamps
    end
    add_index :email_addresses, :user_id
  end
end
