class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone
      t.text :notes
      t.boolean :confirmed_by_robot
      t.boolean :confirmed_by_human
      t.datetime :robot_confirmation_datetime
      t.datetime :human_confirmation_datetime
      t.string :phone_type
      t.string :invisible
      t.integer :user_id
      t.integer :creator_id

      t.timestamps
    end
    add_index :phones, :user_id
  end
end
