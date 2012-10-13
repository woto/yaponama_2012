class CreateTimeZones < ActiveRecord::Migration
  def change
    create_table :time_zones do |t|
      t.string :time_zone
      t.integer :utc_offset_hours
      t.integer :utc_offset_minutes

      t.timestamps
    end
  end
end
