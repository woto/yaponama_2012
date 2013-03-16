class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      # BROWSER
      t.string :location
      t.string :title
      t.string :referrer

      t.references :user

      t.timestamps
    end
    add_index :stats, :user_id
  end
end
