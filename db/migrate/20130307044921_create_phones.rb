class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone
      t.string :phone_type
      t.boolean :confirmed_by_user
      t.boolean :confirmed_by_manager
      t.datetime :user_confirmation_datetime
      t.datetime :manager_confirmation_datetime

      t.timestamps
    end
  end
end
