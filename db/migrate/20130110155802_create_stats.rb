class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      # GEO
      t.string :city
      t.string :country
      t.string :region
      t.string :district
      t.float :lat
      t.float :lng

      # REQUEST
      t.string :remote_ip
      t.string :accept_language
      t.string :user_agent

      # BROWSER
      t.string :datetime
      t.string :location
      t.string :title
      t.string :referrer


      t.references :user

      t.timestamps
    end
    add_index :stats, :user_id
  end
end
