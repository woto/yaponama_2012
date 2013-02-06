class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :creator_id
      t.string :session_id
      t.string :invisible
      t.string :creation_reason
      t.decimal :discount, :precision => 8, :scale => 2
      t.decimal :prepayment_percent, :precision => 8, :scale => 2
      t.references :time_zone
      t.references :ping
      t.string :role
      t.datetime :activity_at
      t.string :auth_token
      t.string :password_digest

      t.timestamps
    end
  end
end
