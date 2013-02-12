class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :creator_id
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
      t.string :password_reset_email_token
      t.string :password_reset_sms_token
      t.datetime :password_reset_sent_at

      # TODO хочу чтобы поля назывались confirmation_token (это в средствах связи уже наверное) и reset_password_token как было на yaponama.ru и devise

      t.timestamps
    end
  end
end
