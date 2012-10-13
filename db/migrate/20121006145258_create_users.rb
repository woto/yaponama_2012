class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :session_id
      t.string :invisible
      t.string :creation_reason
      t.references :time_zone
      t.references :ping

      t.timestamps
    end
  end
end
