class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      # BROWSER
      t.string :location
      t.string :title
      t.string :referrer

      t.references :user, index: true

      t.timestamps
    end
  end
end
