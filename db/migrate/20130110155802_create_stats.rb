class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      # BROWSER
      t.string :location
      t.string :title
      t.string :referrer
      t.integer :screen_width
      t.integer :screen_height
      t.integer :client_width
      t.integer :client_height

      t.references :somebody, index: true

      t.timestamps
    end
  end
end
