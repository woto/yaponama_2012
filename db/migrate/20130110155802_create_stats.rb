class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      # BROWSER
      t.text :location, limit: 2048
      t.string :title
      t.text :referrer, limit: 2048
      t.integer :russian_time_zone_auto_id
      t.integer :screen_width
      t.integer :screen_height
      t.integer :client_width
      t.integer :client_height

      t.references :somebody, index: true

      t.boolean :is_search

      t.timestamps
    end
  end
end
