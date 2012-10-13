class CreatePings < ActiveRecord::Migration
  def change
    create_table :pings do |t|
      t.references :user

      t.timestamps
    end
    add_index :pings, :user_id
  end
end
